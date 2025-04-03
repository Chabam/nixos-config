{ pkgs, ... }:

{
  programs.nixvim = {

    extraPackages = with pkgs; [
      stylua
      texlivePackages.latexindent
      clang-tools
      nixfmt-rfc-style
    ];

    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = false;
        formatters_by_ft = {
          lua = [ "stylua" ];
          tex = [ "latexindent" ];
          cpp = [ "clang_format" ];
          nix = [ "nixfmt" ];
        };
        formatters = {
          stylua = {
            prepend_args = [
              "--indent-type"
              "Spaces"
            ];
          };
          clang_format = {
            prepend_args = [
              "--style=file"
              "--fallback-style=Microsoft"
            ];
          };
        };
      };
    };

    keymaps = [
      {
        mode = "";
        key = "<leader>f";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options = {
          desc = "[F]ormat buffer";
        };
      }
    ];
  };
}
