return {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup {
      fzf_colors = true,
      grep = {
        rg_glob = true,
      },
      keymap = {
        fzf = {
          ['ctrl-q'] = 'select-all+accept',
          ['ctrl-f'] = 'accept',
        },
      },
    }

    vim.keymap.set('n', '<leader>ff', fzf.files)
    vim.keymap.set('n', '<leader>fg', fzf.live_grep)
    vim.keymap.set('n', '<leader>fs', fzf.lsp_document_symbols)
  end,
}
