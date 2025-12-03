return {
  'NickvanDyke/opencode.nvim',
  event = 'VeryLazy',
  config = function()
    local opencode = require('opencode')

    vim.keymap.set({ 'n', 'v' }, '<leader>oc', function() opencode.ask('@this: ', { submit = true }) end)
  end
}
