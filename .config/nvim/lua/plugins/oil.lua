local function new_dir_cache()
  return setmetatable({}, {
    __index = function(self, dir)
      local result = {}

      local proc = vim.system({
        'git', 'ls-tree', 'HEAD', '--name-only',
      }, { text = true, cwd = dir })

      local status = proc:wait()
      if status.code ~= 0 then
        return nil
      end

      for file in vim.gsplit(status.stdout, '\n', { plain = true, trimempty = true }) do
        file = file:gsub('/$', '')
        if file:sub(1, 1) ~= '.' then
          goto next
        end

        result[file] = true
        ::next::
      end

      rawset(self, dir, result)

      return result
    end,
  })
end

return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  after = 'nvim-web-devicons',
  config = function()
    local oil = require('oil')
    local refresh = require('oil.actions').refresh

    local cache = new_dir_cache()
    local refresh_callback = refresh.callback
    refresh.callback = function(...)
      cache = new_dir_cache()
      return refresh_callback(...)
    end

    oil.setup {
      view_options = {
        is_hidden_file = function(name, bufnr)
          if name == '.' or name == '..' then
            return true
          end

          local dir = oil.get_current_dir(bufnr)
          local dotfile = vim.startswith(name, '.')
          if not dir or not dotfile then
            return dotfile
          end

          local info = cache[dir]
          if not info or info[name] == nil then
            return dotfile
          end

          return not info[name]
        end,
      },
    }

    vim.keymap.set('n', '-', oil.open)
  end,
}
