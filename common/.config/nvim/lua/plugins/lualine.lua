return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
  config = function()
    local lualine = require("lualine")
    local theme = require("catppuccin.utils.lualine")("macchiato")

    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        lualine.refresh { place = { "statusline" } }
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        lualine.refresh { place = { "statusline" } }
      end,
    })

    local panel_bg = "#181825"
    theme.normal.c   = { bg = panel_bg, fg = theme.normal.c.fg }
    theme.inactive.a = { bg = panel_bg, fg = theme.inactive.a.fg }
    theme.inactive.b = { bg = panel_bg, fg = theme.inactive.b.fg, gui = theme.inactive.b.gui }
    theme.inactive.c = { bg = panel_bg, fg = theme.inactive.c.fg }

    lualine.setup {
      options = {
        theme = theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          "mode",
          {
            "macro",
            fmt = function()
              local reg = vim.fn.reg_recording()
              if reg == "" then return "" end
              return "recording @" .. reg
            end,
          },
        },
        lualine_z = {
          "location",
        },
      },
    }
  end,
}
