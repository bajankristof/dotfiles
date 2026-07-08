return {
  "stevearc/quicker.nvim",
  event = "VeryLazy",
  config = function()
    local quicker = require("quicker")
    quicker.setup()
  end,
}
