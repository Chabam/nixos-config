{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
  {
    dir = "${iron-nvim}",
    keys = {
      {
        "<space>ti",
        "<cmd>IronRepl<cr><Esc>",
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
          repl_filetype = function(bufnr, ft)
            return "iron"..ft
          end,
          repl_definition = {
            racket = {
              command = { "racket", "-i" },
              format = function(lines, extra)
                local result = {}
                for _, line in ipairs(lines) do
                  if string.sub(line, 1, 1) ~= "#" then
                    table.insert(result, line)
                  end
                end

                table.insert(result, "\n")
                return result
              end
            }
          },
          repl_open_cmd = view.split("50%", {
            winfixwidth = false,
            winfixheight = false
          }),
        },
        keymaps = {
          restart_repl = "<space>iR",
          send_motion = "<space>is",
          visual_send = "<space>is",
          send_file = "<space>if",
          send_line = "<space>il",
          cr = "<space>i<cr>",
          interrupt = "<space>i<space>",
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
