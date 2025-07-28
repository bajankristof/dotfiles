require('config.lazy')
require('config.lsp')
require('config.diagnostic')
require('config.keymap')

-- Enable nerd font support
vim.g.have_nerd_font = true

-- Enable relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Hide command line when not needed
vim.o.cmdheight = 0

-- Keep some space around the cursor
vim.o.scrolloff = 12

-- Display trailing and non-breaking spaces
vim.o.list = true
vim.opt.listchars = { tab = '▏ ', trail = '·', nbsp = '␣' }

-- Enable case-insensitive search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set highlight on search, but clear on pressing escape in normal mode
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')

-- Sync clipboard with system clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

