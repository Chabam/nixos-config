{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.nvidia;
in
{

  options = {
    nvidia.enable = lib.mkEnableOption {
      description = "Enable Nvidia GPU";
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.cudaSupport = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
      };
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    environment = {
      systemPackages = [ pkgs.libva-utils ];
      variables = {
        NVD_BACKEND = "direct";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm";
      };
    };

    systemd.services.systemd-suspend.environment = {
      SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    };
  };
}
