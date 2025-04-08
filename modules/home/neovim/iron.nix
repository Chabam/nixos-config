{ pkgs }:
with pkgs.vimPlugins;
''
  {
    dir = "${iron-nvim}",
    keys = {
      {
        "<space>ti",
        require("iron.core").toggle_repl,
        desc = "[T]oggle [I]ron"
      },
      {
        "<leader>iR",
        require("iron.core").restart_repl,
        desc = "[I]ron [R]estart"
      },
      {
        "<leader>I",
        require("iron.core").send_motion,
        desc = "[I]ron send motion"
      },
      {
        "<leader>im",
        require("iron.core").visual_send,
        "v",
        desc = "[I]ron send visual motion"
      },
      {
        "<leader>if",
        require("iron.core").send_file,
        desc = "[I]ron send [f]ile"
      },
      {
        "<leader>il",
        require("iron.core").send_line,
        desc = "[I]ron send [l]ine"
      },
      {
        "<leader>i<cr>",
        require("iron.core").cr,
        desc = "[I]ron line return"
      },
      {
        "<leader>i<space>",
        require("iron.core").interrupt,
        desc = "[I]ron interrupt"
      },
      {
        "<leader>iq",
        require("iron.core").exit,
        desc = "[I]ron [q]uit"
      },
      {
        "<leader>icl",
        require("iron.core").clear,
        desc = "[I]ron [cl]ear"
      },
      {
        "<space>if",
        "<cmd>IronFocus<cr>",
        desc = "[I]ron [f]ocus"
      },
      {
        "<space>ih",
        "<cmd>IronHide<cr>",
        desc = "[I]ron [h]ide"
      }
    },
    init = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      iron.setup({
        config = {
          highlight_last = "IronLastSent",
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = {"zsh"}
            },
            python = {
              command = { "python3" },  -- or { "ipython", "--no-autoindent" }
              format = common.bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
            }
          },
          repl_filetype = function(bufnr, ft)
            return "iron"..ft
          end,
          repl_open_cmd = view.split("40%"),
        },
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
    })
  end,
}
''
