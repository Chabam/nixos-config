{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
{
  dir = "${oil-nvim}",
  keys = {
    {
      "<leader>-",
      "<CMD>Oil<CR>",
      desc = "Open parent directory"
    }
  },
  init = function()
    local oil = require("oil")

    local detail = true
    oil.setup({
      default_file_explorer = true,
      watch_for_changes = true,
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              oil.set_columns({ "icon", "permissions", "size", "mtime" })
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
      },
      win_options = {
        signcolumn = "yes:2",
      },
      buf_options = {
        buflisted = true
      }
    })
   end
}
''
