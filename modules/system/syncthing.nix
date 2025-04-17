{ config, lib, ... }:
let
  cfg = config.syncthing;
in
{
  options = {
    syncthing.openSystemPorts = lib.mkEnableOption {
      name = "Enable syncthing port";
      default = true;
    };
  };

  config = lib.mkIf cfg.openSystemPorts {
    networking.firewall.allowedTCPPorts = [
      8384
      22000
    ];
    networking.firewall.allowedUDPPorts = [
      22000
      21027
    ];
  };
}
