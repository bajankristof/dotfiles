return {
  "bajankristof/fileref.nvim",
  event = "VeryLazy",
  config = function()
    local fileref = require("fileref")

    vim.keymap.set({ "n", "v" }, "<leader>fy", fileref.yank)
  end,
}
