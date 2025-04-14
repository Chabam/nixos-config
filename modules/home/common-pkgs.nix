{ pkgs, inputs, ... }:
let
  guiApps = with pkgs; [
    discord
    firefox
    teams-for-linux
  ];
  cliApps = with pkgs; [
    fd
    git
    lazygit
    nnn
    ripgrep
    tree
    wget
    wl-clipboard
  ];
in
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = guiApps ++ cliApps;

  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    packages = [
      "org.blender.Blender"
      "org.gimp.GIMP"
    ];
  };
}
