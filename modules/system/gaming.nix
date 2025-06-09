{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.gaming;
  openmw-unstable = pkgs.callPackage ./openmw-unstable.nix { };
in
{
  options = {
    gaming = {
      enable = lib.mkEnableOption "Enable GAMING";
      morrowind = lib.mkEnableOption "Enable OpenMW";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
      };
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
    };
    environment.systemPackages = lib.mkIf cfg.morrowind [
      openmw-unstable
    ];
  };
}
