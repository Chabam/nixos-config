{ ... }:

{
  programs.nixvim = {

    plugins.fzf-lua = {
      enable = true;

      settings = {
        fzf_opts = {
          "--pointer" = " ";
          "--separator" = " ";
        };
        fzf_colors = {
          "fg" = [
            "fg"
            "Comment"
          ];
          "bg" = [
            "bg"
            "palette.bg0"
          ];
          "hl" = [
            "fg"
            "Normal"
          ];
          "fg+" = [
            "fg"
            "Comment"
            "bold"
          ];
          "bg+" = [
            "bg"
            [
              "palette.sel0"
              "Normal"
            ]
          ];
          "hl+" = [
            "fg"
            "Normal"
          ];
          "info" = [
            "fg"
            "NonText"
          ];
          "prompt" = [
            "fg"
            "FzfLuaBufLineNr"
          ];
          "spinner" = [
            "fg"
            "FzfLuaBufNr"
          ];
          "header" = [
            "fg"
            "Normal"
          ];
          "query" = [
            "fg"
            "palette.green"
          ];
          "gutter" = "-1";
        };
        winopts = {
          backdrop = false;
          height = 0.7;
          width = 0.65;
          preview = {
            layout = "vertical";
          };
        };
      };

      keymaps = {
        "<leader>sh" = {
          action = "helptags";
          options = {
            desc = "[S]earch [H]elp";
          };
        };
        "<leader>sk" = {
          action = "keymaps";
          options = {
            desc = "[S]earch [K]eymaps";
          };
        };
        "<leader>sf" = {
          action = "files";
          options = {
            desc = "[S]earch [F]iles";
          };
        };
        "<leader>ss" = {
          action = "builtin";
          options = {
            desc = "[S]earch [S]elect fzf";
          };
        };
        "<leader>sw" = {
          action = "grep_cword";
          options = {
            desc = "[S]earch current [W]ord";
          };
        };
        "<leader>sg" = {
          action = "live_grep_native";
          options = {
            desc = "[S]earch by [G]rep";
          };
        };
        "<leader>sr" = {
          action = "resume";
          options = {
            desc = "[S]earch [R]esume";
          };
        };
        "<leader>sb" = {
          action = "buffers";
          options = {
            desc = "[S]earch existing [B]uffers";
          };
        };
      };
    };
  };
}
