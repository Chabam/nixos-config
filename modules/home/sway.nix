{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ptyxis;
in
{

  options = {
    sway.enable = lib.mkEnableOption "Enable Sway";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      checkConfig = true;
      config = {
        terminal = "ptyxis";
      };
    };
  };
}
