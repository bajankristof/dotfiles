return {
  'nvim-tree/nvim-web-devicons',
  lazy = false,
  config = function()
    local devicons = require('nvim-web-devicons')

    devicons.setup {
      override_by_filename = {
        ['Dockerfile.dev'] = {
          icon = '󰡨',
          color = '#458EE6',
          name = 'Dockerfile',
        },
      },
    }
  end,
}
