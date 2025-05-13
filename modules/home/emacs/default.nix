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
  theme = "${emacsConfigDir}/oxocarbon-theme.el";
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

    xdg.configFile."emacs/init.el".source = config.lib.file.mkOutOfStoreSymlink initEl;
    xdg.configFile."emacs/chabam-theme.el".source = config.lib.file.mkOutOfStoreSymlink theme;
  };
}
