{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "gamer"; # Define your hostname.

  main-user = {
    userName = "chabam";
    fullName = "Chabam";
  };

  nvidia.enable = true;
  syncthing.openSystemPorts = true;
  uni-remote.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
