{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "flsh-georf32"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  main-user = {
    userName = "chaf2717";
    fullName = "Félix Chabot";
  };

  nvidia.enable = true;
  syncthing.openSystemPorts = true;
  uni-remote.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts = {
    packages = with pkgs; [
      nerd-fonts.iosevka-term
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>1080</x>
            <y>439</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>HPN</vendor>
                <product>HP E223</product>
                <serial>3CQ903062P</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-1</connector>
                <vendor>HPN</vendor>
                <product>HP E223</product>
                <serial>3CQ9030635</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    ''}"
  ];
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
