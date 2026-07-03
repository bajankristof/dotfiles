return {
  "saghen/blink.cmp",
  name = "blink",
  version = "1.*",
  event = "InsertEnter",
  config = function()
    local blink = require("blink.cmp")

    blink.setup {
      keymap = { preset = "default" },
      signature = { enabled = true },
      appearance = {
        nerd_font_variant = "mono",
      },
    }

    vim.lsp.config("*", {
      capabilities = blink.get_lsp_capabilities(),
    })
  end,
}
