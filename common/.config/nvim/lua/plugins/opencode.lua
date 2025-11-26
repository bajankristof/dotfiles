return {
  'NickvanDyke/opencode.nvim',
  event = 'VeryLazy',
  config = function()
    local opencode = require('opencode')

    vim.keymap.set('n', '<leader>oc', function() opencode.ask('@cursor: ') end)
    vim.keymap.set('v', '<leader>oc', function() opencode.ask('@selection: ') end)
  end
}
