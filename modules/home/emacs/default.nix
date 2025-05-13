{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.emacs;
  emacsConfigDir = "${config.home.homeDirectory}/Sources/nixos-config/modules/home/emacs/config";
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
          epkgs.ef-themes
          epkgs.evil
        ]
      );
    };

    xdg.configFile."emacs".source = config.lib.file.mkOutOfStoreSymlink emacsConfigDir;
  };
}
