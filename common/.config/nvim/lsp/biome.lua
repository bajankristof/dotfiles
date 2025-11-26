return {
  cmd = function(dispatchers, config)
    if not config.root_dir then
      return
    end

    return vim.lsp.rpc.start({
      config.root_dir .. '/node_modules/.bin/biome',
      'lsp-proxy',
    }, dispatchers)
  end,
  filetypes = {
    'astro',
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'svelte',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
    'vue',
  },
  root_dir = function(bufnr, cb)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local root_dir = vim.fs.root(bufname, { { 'package.json', 'biome.json' } })
    if not root_dir then
      return
    end

    if vim.fn.executable(root_dir .. '/node_modules/.bin/biome') ~= 1 then
      return
    end

    cb(root_dir)
  end,
}
