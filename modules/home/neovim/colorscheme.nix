{ pkgs }:
with pkgs.vimPlugins;
''
  {
      dir = "${adwaita-nvim}",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.terminal_color_0 = "#241f31"
        vim.g.terminal_color_1 = "#c01c28"
        vim.g.terminal_color_2 = "#2ec27e"
        vim.g.terminal_color_3 = "#f5c211"
        vim.g.terminal_color_4 = "#1e78e4"
        vim.g.terminal_color_5 = "#9841bb"
        vim.g.terminal_color_6 = "#0ab9dc"
        vim.g.terminal_color_7 = "#c0bfbc"
        vim.g.terminal_color_8 = "#5e5c64"
        vim.g.terminal_color_9 = "#ed333b"
        vim.g.terminal_color_10 = "#57e389"
        vim.g.terminal_color_11 = "#f8e45c"
        vim.g.terminal_color_12 = "#51a1ff"
        vim.g.terminal_color_13 = "#c061cb"
        vim.g.terminal_color_14 = "#4fd2fd"
        vim.g.terminal_color_15 = "#f6f5f4"

        vim.g.adwaita_disable_cursorline = false
        vim.g.adwaita_transparent = false

        vim.cmd.colorscheme("adwaita")

        -- Minor adjustments to the colorscheme
        vim.schedule(function()
            vim.api.nvim_set_hl(0, 'ModeMsg', { link = "Structure" })
            vim.api.nvim_set_hl(0, 'OilDir', { link = "Structure" })
            vim.api.nvim_set_hl(0, 'StatusLine', { link = "WildMenu" })
            vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = "#deddda", bg="#303030" })

            vim.api.nvim_set_hl(0, "Error", { undercurl = true, fg="#e01b24", bg="#1d1d1d" })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { link = "Error" })
        end)
      end,
    }
''
