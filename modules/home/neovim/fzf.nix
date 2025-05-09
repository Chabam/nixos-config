{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
  {
  dir = "${fzf-lua}",
  keys = {
    {
      "<leader>sh",
      require("fzf-lua").helptags,
      "n",
      desc = "[S]earch [H]elp"
    },
    {
      "<leader>sk",
      require("fzf-lua").keymaps,
      "n",
      desc = "[S]earch [K]eymaps"
    },
    {
      "<leader>sf",
      require("fzf-lua").files,
      "n",
      desc = "[S]earch [F]iles"
    },
    {
      "<leader>ss",
      require("fzf-lua").builtin,
      "n",
      desc = "[S]earch [S]elect fzf"
    },
    {
      "<leader>sw",
      require("fzf-lua").grep_cword,
      "n",
      desc = "[S]earch current [W]ord"
    },
    {
      "<leader>sg",
      require("fzf-lua").live_grep_native,
      "n",
      desc = "[S]earch by [G]rep"
    },
    {
      "<leader>sd",
      require("fzf-lua").diagnostics_document,
      "n",
      desc = "[S]earch [D]iagnostics"
    },
    {
      "<leader>sr",
      require("fzf-lua").resume,
      "n",
      desc = "[S]earch [R]esume"
    },
    {
      "<leader>sb",
      require("fzf-lua").buffers,
      "n",
      desc = "[S]earch existing [B]uffers"
    },
  },
  cmd = "FzfLua",
  event = "VeryLazy",
  init = function()
    vim.ui.select = function(...)
      require("fzf-lua").register_ui_select()
      return vim.ui.select(...)
    end
  end,
  config = function()
    local fzf = require("fzf-lua")
    require("fzf-lua").setup({
      fzf_opts = {
        ["--pointer"] = " ",
        ["--separator"] = " ",
      },
      actions = {
        files = {
          ["ctrl-y"] = fzf.actions.file_edit_or_qf,
          ["enter"] = fzf.actions.file_edit_or_qf,
          ["ctrl-s"] = fzf.actions.file_split,
          ["ctrl-v"] = fzf.actions.file_vsplit,
          ["ctrl-t"] = fzf.actions.file_tabedit,
          ["alt-q"] = fzf.actions.file_sel_to_qf,
          ["alt-Q"] = fzf.actions.file_sel_to_ll,
          ["alt-i"] = fzf.actions.toggle_ignore,
          ["alt-h"] = fzf.actions.toggle_hidden,
          ["alt-f"] = fzf.actions.toggle_follow,
        },
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
  end,
  }
''
