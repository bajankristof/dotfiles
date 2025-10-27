return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    event = 'VeryLazy',
    build = ':TSUpdate',
    init = function(plugin)
      require('lazy.core.loader').add_to_rtp(plugin)
    end,
    config = function()
      local treesitter = require('nvim-treesitter')

      treesitter.install {
        'bash',
        'c_sharp',
        'css',
        'go',
        'hcl',
        'html',
        'javascript',
        'lua',
        'make',
        'ruby',
        'scss',
        'sql',
        'terraform',
        'tsx',
        'typescript',
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local textobjects = require('nvim-treesitter-textobjects')
      local select = require('nvim-treesitter-textobjects.select')

      textobjects.setup()

      vim.keymap.set({ 'o', 'x' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'al', function() select.select_textobject('@block.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'il', function() select.select_textobject('@block.inner', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ai', function() select.select_textobject('@conditional.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ii', function() select.select_textobject('@conditional.inner', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ap', function() select.select_textobject('@parameter.outer', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'ip', function() select.select_textobject('@parameter.inner', 'textobjects') end)
      vim.keymap.set({ 'o', 'x' }, 'as', function() select.select_textobject('@local.scope', 'locals') end)
    end,
  },
}
