{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./auto-upgrade.nix
    ./flatpak.nix
    ./gaming.nix
    ./gc.nix
    ./gnome.nix
    ./grub.nix
    ./main-user.nix
    ./nvidia.nix
    ./plymouth.nix
    ./syncthing.nix
    ./uni-remote.nix
    ./virt-manager.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.iosevka-term
    ];
  };

  environment.variables = {
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  programs.firefox = {
    enable = true;
    preferences = lib.mkIf config.nvidia.enable {
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "media.rdd-ffmpeg.enabled" = true;
      "media.av1.enabled" = true;
      "gfx.x11-egl.force-enabled" = true;
      "widget.dmabuf.force-enabled" = true;
    };
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  services.xserver.excludePackages = [ pkgs.xterm ];

  virtualisation.docker.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Cleanup /tmp
  boot.tmp.cleanOnBoot = true;
}
