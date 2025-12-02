local augroup = vim.api.nvim_create_augroup('RoslynLS', { clear = true })

---@param root_dir string
---@return string?
local function find_sln(root_dir)
  for entry, type in vim.fs.dir(root_dir) do
    if type == 'file' and entry:match('%.sln[x]?$') then
      return vim.fs.joinpath(root_dir, entry)
    end
  end
end

---@param root_dir string
---@return string?
local function find_csproj(root_dir)
  for entry, type in vim.fs.dir(root_dir) do
    if type == 'file' and entry:match('%.csproj$') then
      return vim.fs.joinpath(root_dir, entry)
    end
  end
end

---@param client vim.lsp.Client
---@return nil
local function refresh_diagnostics(client)
  local buffers = vim.lsp.get_buffers_by_client_id(client.id)
  for _, bufnr in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      client:request('textDocument/diagnostic', {
        textDocument = vim.lsp.util.make_text_document_params(bufnr)
      }, nil, bufnr)
    end
  end
end

return {
  cmd = {
    'dotnet',
    vim.fn.expand('~/.local/share/roslynls/Microsoft.CodeAnalysis.LanguageServer.dll'),
    '--stdio',
    '--logLevel',
    -- 'Trace',
    'Information',
    '--extensionLogDirectory',
    vim.fn.expand('~/.local/state/roslynls/logs'),
  },
  filetypes = { 'cs' },
  offset_encoding = 'utf-8',
  root_dir = function(bufnr, cb)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local root_dir = vim.fs.root(bufname, function(fname, _)
      return fname:match('%.sln[x]?$') ~= nil
    end)

    if not root_dir then
      root_dir = vim.fs.root(bufname, function(fname, _)
        return fname:match('%.csproj$') ~= nil
      end)
    end

    if root_dir then
      cb(root_dir)
    end
  end,
  on_init = function(client, _)
    local root_dir = client.config.root_dir
    if not root_dir then
      return
    end

    local sln = find_sln(root_dir)
    if sln then
      client.notify('solution/open', {
        solution = vim.uri_from_fname(sln)
      })
    else
      local csproj = find_csproj(root_dir)
      if csproj then
        client.notify('project/open', {
          projects = { vim.uri_from_fname(csproj) }
        })
      end
    end
  end,
  on_attach = function(client, bufnr)
    local autocmds = vim.api.nvim_get_autocmds({
      event = 'BufWritePost',
      group = augroup,
      buffer = bufnr,
    })

    if autocmds[1] then
      return
    end

    vim.api.nvim_create_autocmd('BufWritePost', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        refresh_diagnostics(client)
      end,
    })
  end,
  handlers = {
    ['workspace/projectInitializationComplete'] = function(_, _, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if not client then
        return vim.NIL
      end

      refresh_diagnostics(client)

      return vim.NIL
    end,
    ['workspace/_roslyn_projectNeedsRestore'] = function(_, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if not client then
        return vim.NIL
      end

      client:request('workspace/_roslyn_restore', result, function(error, _)
        if error then
          vim.notify(error.message, vim.log.levels.ERROR, { title = 'Roslyn LS' })
        end
      end)

      return vim.NIL
    end,
  },
  capabilities = {
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    ['csharp|background_analysis'] = {
      dotnet_analyzer_diagnostics_scope = 'fullSolution',
      dotnet_compiler_diagnostics_scope = 'fullSolution',
    },
    ['csharp|inlay_hints'] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      dotnet_enable_inlay_hints_for_other_parameters = true,
      dotnet_enable_inlay_hints_for_parameters = true,
      dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
    },
    ['csharp|symbol_search'] = {
      dotnet_search_reference_assemblies = true,
    },
    ['csharp|completion'] = {
      dotnet_show_name_completion_suggestions = true,
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_provide_regex_completions = true,
    },
    ['csharp|code_lens'] = {
      dotnet_enable_references_code_lens = true,
    },
  },
}
