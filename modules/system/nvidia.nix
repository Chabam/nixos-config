{ pkgs, config, ... }:

{

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
}
