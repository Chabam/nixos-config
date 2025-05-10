{
  lib,
  config,
  ...
}:
let
  cfg = config.gaming;
in
{
  options = {
    sway = {
      enable = lib.mkEnableOption "Enable Sway";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      sway = {
        enable = true;
        wrapperFeatures = {
          base = true;
          gtk = true;
        };

        xwayland.enable = true;
        extraOptions = lib.optionals config.nvidia.enable [
          "--unsupported-gpu"
        ];
      };

      waybar.enable = true;
    };
  };
}
