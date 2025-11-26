return {
  'github/copilot.vim',
  event = { 'InsertEnter', 'VeryLazy' },
  config = function()
    vim.g.copilot_no_tab_map = true

    vim.keymap.set('i', '<C-f>', 'copilot#Accept("")', { expr = true, replace_keycodes = false })
    vim.keymap.set('i', '<C-j>', 'copilot#AcceptWord("")', { expr = true, replace_keycodes = false })
    vim.keymap.set('i', '<C-n>', 'copilot#Dismiss()', { expr = true, replace_keycodes = false })
  end,
}
