local root_dir = vim.fs.root(0, {
  'deno.json',
  'deno.jsonc',
  'tsconfig.json',
  'jsconfig.json',
  'package.json',
})

if root_dir then
  if vim.fs.find({'deno.json', 'deno.jsonc'}, { path = root_dir, upward = false })[1] then
    vim.lsp.enable('denols')
  else
    vim.lsp.enable('tsgo')
    vim.lsp.enable('biome')
  end
end

vim.treesitter.start()
