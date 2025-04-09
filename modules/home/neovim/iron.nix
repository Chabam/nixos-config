{ pkgs }:
with pkgs.vimPlugins;
''
  {
    dir = "${iron-nvim}",
    keys = {
      {
        "<space>ti",
        "<cmd>IronRepl<cr>",
        desc = "[T]oggle [I]ron"
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
        keymaps = {
          restart_repl = "<space>iR",
          send_motion = "<space>is",
          visual_send = "<space>is",
          send_file = "<space>if",
          send_line = "<space>il",
          cr = "<space>i<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>iq",
          clear = "<space>ic",
        },
        highlight = {
          bold = true
        },
        ignore_blank_lines = true,
    })
  end,
}
''
