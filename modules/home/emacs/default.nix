{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.emacs;
  emacsPackage = pkgs.emacs.override {
    withGTK3 = true;
    withTreeSitter = true;
  };
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
    home.packages = with pkgs; [
      languagetool
      (aspellWithDicts (dicts : with dicts; [
        en en-computers en-science fr
      ]))
    ];

    programs.emacs = {
      enable = true;
      package = emacsPackage;
      extraPackages = (
        epkgs: with epkgs; [
          auto-dark
          corfu
          direnv
          expand-region
          flyspell-correct
          langtool
          langtool-popup
          git-gutter
          git-gutter-fringe
          magit
          marginalia
          nix-mode
          no-littering
          orderless
          racket-mode
          smartparens
          treesit-auto
          treesit-grammars.with-all-grammars
          vertico
          vundo
          visual-regexp
          vterm
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
