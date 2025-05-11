{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.sway;
in
{

  options = {
    sway.enable = lib.mkEnableOption "Enable Sway";
  };

  config = lib.mkIf cfg.enable {

    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
    };

    wayland.windowManager.sway = {
      enable = true;
      checkConfig = true;
      config = {
        terminal = "kitty";
      };
    };
  };
}
