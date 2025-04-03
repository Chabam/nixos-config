{ inputs, pkgs, ... }:

{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        fish
        markdown
        make
        lua
        c
        cpp
        python
        racket
        nix
      ];
    };
  };
}
