return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    local flash = require('flash')

    vim.keymap.set('n', 's', flash.jump)
  end,
}
