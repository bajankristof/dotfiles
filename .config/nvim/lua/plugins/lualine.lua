return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require('lualine')

    vim.api.nvim_create_autocmd('RecordingEnter', {
      callback = function()
        lualine.refresh { place = { 'statusline' } }
      end
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      callback = function()
        lualine.refresh { place = { 'statusline' } }
      end
    })

    lualine.setup {
      options = {
        theme = 'catppuccin',
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            separator = { left = '' },
            right_padding = 2
          },
          {
            'macro',
            fmt = function()
              local reg = vim.fn.reg_recording()
              if reg == '' then return '' end
              return 'recording @' .. reg
            end,
          },
        },
        lualine_z = {
          {
            'location',
            separator = { right = '' },
            left_padding = 2
          },
        },
      },
    }
  end
}
