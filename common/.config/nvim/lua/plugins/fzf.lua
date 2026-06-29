return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup {
      ui_select = true,
      fzf_colors = true,
      winopts = {
        border = "rounded",
        preview = {
          border    = "rounded",
          title     = true,
          title_pos = "center",
        },
      },
      files = {
        cwd_prompt = false,
      },
      grep = {
        hidden = true,
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
          ["ctrl-f"] = "accept",
        },
      },
    }

    vim.keymap.set("n", "<leader>ff", fzf.files)
    vim.keymap.set("n", "<leader>fg", fzf.live_grep)
    vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols)
  end,
}
