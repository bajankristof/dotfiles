return {
  'catppuccin/nvim',
  config = function ()
    local catppuccin = require('catppuccin')

    catppuccin.setup {
      flavour = 'macchiato',
      integrations = {
        blink_cmp = true,
        copilot_vim = true,
        flash = true,
        fzf = true,
        treesitter = true,
      },
    }

    vim.cmd('colorscheme catppuccin')
  end
}
