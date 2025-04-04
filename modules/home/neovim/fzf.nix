{ pkgs }:
with pkgs.vimPlugins;
''
  {
  dir = "${fzf-lua}",
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
    fzf_opts = {
      ["--pointer"] = " ",
      ["--separator"] = " ",
    },
    fzf_colors = {
      ["fg"] = { "fg", "Comment" },
      ["bg"] = { "bg", "palette.bg0" },
      ["hl"] = { "fg", "Normal" },
      ["fg+"] = { "fg", "Comment", "bold" },
      ["bg+"] = { "bg", { "palette.sel0", "Normal" } },
      ["hl+"] = { "fg", "Normal" },
      ["info"] = { "fg", "NonText" },
      ["prompt"] = { "fg", "FzfLuaBufLineNr" },
      ["spinner"] = { "fg", "FzfLuaBufNr" },
      ["header"] = { "fg", "Normal" },
      ["query"] = { "fg", "palette.green" },
      ["gutter"] = "-1",
    },
    winopts = {
      backdrop = false,
      height = 0.7,
      width = 0.65,
      preview = {
      layout = "vertical",
        },
    },
    })
    fzf.register_ui_select()
  end,
  }
''
