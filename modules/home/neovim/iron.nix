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
                local starts_with = function(line, val)
                  return line:gsub("%s+", ""):sub(1, #val) == val
                end
                for _, line in ipairs(lines) do
                  if not (starts_with(line, "#") or starts_with(line, ";")) then
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
          restart_repl = "<leader>ir",
          send_motion = "<leader>is",
          visual_send = "<leader>is",
          send_file = "<leader>if",
          send_line = "<leader>il",
          cr = "<leader>i<cr>",
          interrupt = "<leader>i<leader>",
          exit = "<leader>iq",
          clear = "<leader>ic",
        },
        highlight = {
          bold = true
        },
        ignore_blank_lines = true,
    })
  end,
}
''
