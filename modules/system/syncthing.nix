{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    group = "users";
    user = "chabam";
    enable = true;
    openDefaultPorts = true;
  };
}
