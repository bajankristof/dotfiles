local mod_cache = nil

---@param fname string
---@return string?
local function get_root_dir(fname)
  if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
    local clients = vim.lsp.get_clients { name = 'gopls' }
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end

  return vim.fs.root(fname, 'go.work') or vim.fs.root(fname, 'go.mod') or vim.fs.root(fname, '.git')
end

return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(bufnr, on_dir)
    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if mod_cache then
      on_dir(get_root_dir(fname))
      return
    end

    local cmd = { 'go', 'env', 'GOMODCACHE' }
    vim.system(cmd, { text = true }, function(output)
      if output.code == 0 then
        if output.stdout then
          mod_cache = vim.trim(output.stdout)
        end
        on_dir(get_root_dir(fname))
      else
        vim.api.nvim_echo({
          { string.format('Error detected while running gopls (code %d)\n', output.code), 'ErrorMsg' },
          { string.format('%s\n', output.stderr), 'WarningMsg' },
        }, true, {})
      end
    end)
  end,
}
