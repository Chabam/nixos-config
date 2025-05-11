{ pkgs, ... }:

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

  services.printing.drivers = with pkgs; [
    brlaser
    brgenml1lpr
    brgenml1cupswrapper
  ];

  nvidia.enable = false;
  syncthing.openSystemPorts = true;
  uni-remote.enable = true;
  gaming.enable = true;
  services.hardware.bolt.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment?
}
