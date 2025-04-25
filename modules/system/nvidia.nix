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
    };

    environment = {
      systemPackages = [ pkgs.libva-utils ];
      variables = {
        NVD_BACKEND = "direct";
        LIBVA_DRIVER_NAME = "nvidia";
      };
    };

    systemd.services.systemd-suspend.environment = {
      SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    };

    systemd = {
      services."gnome-suspend" = {
        description = "suspend gnome shell";
        before = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
          "nvidia-suspend.service"
          "nvidia-hibernate.service"
        ];
        wantedBy = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = ''${pkgs.procps}/bin/pkill -f -STOP ${pkgs.gnome-shell}/bin/gnome-shell'';
        };
      };
      services."gnome-resume" = {
        description = "resume gnome shell";
        after = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
          "nvidia-resume.service"
        ];
        wantedBy = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = ''${pkgs.procps}/bin/pkill -f -CONT ${pkgs.gnome-shell}/bin/gnome-shell'';
        };
      };
    };
  };
}
