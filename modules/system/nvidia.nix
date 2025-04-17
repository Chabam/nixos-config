{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.nvidia;
in {

  options = {
    nvidia.enable = lib.mkEnableOption "Enable Nvidia GPU";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.extraModprobeConfig = ''
      options nvidia_modeset vblank_sem_control=0
    '';

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      nvidiaPersistenced = true;
      nvidiaSettings = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    systemd.services.systemd-suspend.environment = {
      SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    };
  };
}
