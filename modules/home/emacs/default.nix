{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.emacs;
  emacsConfigDir = "${config.home.homeDirectory}/Sources/nixos-config/modules/home/emacs/config/";
  initEl = "${emacsConfigDir}/init.el";
  themeDark = "${emacsConfigDir}/chabam-dark-theme.el";
  themeLight = "${emacsConfigDir}/chabam-light-theme.el";
  custom = "${emacsConfigDir}/custom.el";
in
{
  options = {
    emacs.enable = lib.mkEnableOption "Enable Emacs";
  };

  config = lib.mkIf cfg.enable {

    programs.emacs = {
      enable = true;
      package = pkgs.emacs-gtk;
      extraPackages = (
        epkgs: with epkgs; [
    	  corfu
    	  direnv
    	  git-gutter
    	  git-gutter-fringe
    	  magit
    	  orderless
    	  tree-sitter
          tree-sitter-langs
    	  treesit-auto
    	  vertico
          evil
        ]
      );
    };

    home.file = {

      ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink initEl;
      ".emacs.d/chabam-dark-theme.el".source = config.lib.file.mkOutOfStoreSymlink themeDark;
      ".emacs.d/chabam-light-theme.el".source = config.lib.file.mkOutOfStoreSymlink themeLight;
      ".emacs.d/custom.el".source = config.lib.file.mkOutOfStoreSymlink custom;
    };
  };
}
