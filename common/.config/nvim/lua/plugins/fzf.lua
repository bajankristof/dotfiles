return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup {
      ui_select = true,
      fzf_colors = true,
      files = {
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
        rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
      },
      grep = {
        rg_glob = true,
        rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g "!.git" -e]],
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
