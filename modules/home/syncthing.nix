{ osConfig, ... }:

{
  services.syncthing = {
    enable = osConfig.syncthing.openSystemPorts;
  };
}
