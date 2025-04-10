{ pkgs, config, ... }:

{

  services.xserver.videoDrivers = [ "nvidia" ];

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

  # Weird fix for blank screen after suspend
  systemd.services = {
    systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    nvidia-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    nvidia-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    pre-sleep.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    post-resume.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd-hibernate-clear.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd-hybrid-sleep.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd-suspend-then-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    homed-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    homed-hybrid-sleep.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    homed-suspend-then-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  };
}
