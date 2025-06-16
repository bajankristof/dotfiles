function bootstrap()
  local path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

  if not (vim.uv or vim.loop).fs_stat(path) then
    local url = 'https://github.com/folke/lazy.nvim.git'
    local output = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', url, path })

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { string.format('Error detected while cloning %s\n', url) 'ErrorMsg' },
        { string.format('%s\n', output),                                     'WarningMsg' },
        { "\nPress ENTER to exit" }
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end

  return path
end

vim.opt.rtp:prepend(bootstrap())

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
