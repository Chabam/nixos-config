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
  theme = "${emacsConfigDir}/chabam-theme.el";
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
        epkgs: [
          epkgs.autothemer
          epkgs.direnv
          epkgs.ef-themes
          epkgs.evil
        ]
      );
    };

    home.file = {

      ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink initEl;
      ".emacs.d/chabam-theme.el".source = config.lib.file.mkOutOfStoreSymlink theme;
      ".emacs.d/custom.el".source = config.lib.file.mkOutOfStoreSymlink custom;
    };
  };
}
