{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "chungus"; # Define your hostname.
  # Define a user account. Don't forget to set a password with ‘passwd’.
  main-user = {
    userName = "chabam";
    fullName = "Chabam";
  };

  nvidia.enable = true;
  syncthing.openSystemPorts = true;
  uni-remote.enable = true;
  gaming = {
    enable = true;
    morrowind = true;
  };

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
<monitors version="2">
  <configuration>
    <layoutmode>physical</layoutmode>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-3</connector>
          <vendor>AUS</vendor>
          <product>ROG XG279Q</product>
          <serial>LALMQS128555</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>143.972</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
  <configuration>
    <layoutmode>physical</layoutmode>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-0</connector>
          <vendor>AUS</vendor>
          <product>ROG XG279Q</product>
          <serial>LALMQS128555</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>143.972</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
  <configuration>
    <layoutmode>physical</layoutmode>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-4</connector>
          <vendor>AUS</vendor>
          <product>ROG XG279Q</product>
          <serial>LALMQS128555</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>143.972</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
  <configuration>
    <layoutmode>physical</layoutmode>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-1</connector>
          <vendor>AUS</vendor>
          <product>ROG XG279Q</product>
          <serial>LALMQS128555</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>143.972</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
  <configuration>
    <layoutmode>physical</layoutmode>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-1-1</connector>
          <vendor>AUS</vendor>
          <product>ROG XG279Q</product>
          <serial>LALMQS128555</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>143.972</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
  <configuration>
    <layoutmode>physical</layoutmode>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <transform>
        <rotation>right</rotation>
        <flipped>no</flipped>
      </transform>
      <monitor>
        <monitorspec>
          <connector>DP-2</connector>
          <vendor>DEL</vendor>
          <product>DELL U2518D</product>
          <serial>0WG2J85HAG7L</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>59.951</rate>
        </mode>
      </monitor>
    </logicalmonitor>
    <logicalmonitor>
      <x>1440</x>
      <y>577</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-3</connector>
          <vendor>AUS</vendor>
          <product>ROG XG279Q</product>
          <serial>LALMQS128555</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>143.972</rate>
        </mode>
      </monitor>
    </logicalmonitor>
  </configuration>
</monitors>
    ''}"
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
