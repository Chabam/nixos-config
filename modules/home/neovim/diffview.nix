{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
  {
    dir = "${diffview-nvim}",
    keys = {
      {
        "<leader>do",
        "<CMD>DiffviewOpen<CR>",
        desc = "[D]iffview [O]pen"
      },
      {
        "<leader>dc",
        "<CMD>DiffviewClose<CR>",
        desc = "[D]iffview [C]lose"
      }
    },
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed"
        }
      }
    }
  }
''
