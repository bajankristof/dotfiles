local function bootstrap()
  local path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

  if not (vim.uv or vim.loop).fs_stat(path) then
    local url = 'https://github.com/folke/lazy.nvim.git'
    local output = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', url, path })

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { string.format('Error detected while cloning %s\n', url), 'ErrorMsg' },
        { string.format('%s\n', output), 'WarningMsg' },
        { '\nPress ENTER to exit' }
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end

  return path
end

vim.opt.rtp:prepend(bootstrap())

require('lazy').setup({
  spec = {{ import = 'plugins' }},
  install = { colorscheme = { 'habamax' } },
  checker = { enabled = true, frequency = 7 * 24 * 60 * 60 },
})
