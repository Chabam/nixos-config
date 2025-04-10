{ pkgs, ... }:
let
  guiApps = with pkgs; [
    blender
    discord
    firefox
    gimp
    teams-for-linux
  ];
  cliApps = with pkgs; [
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

  nixpkgs.config.allowUnfree = true;

  home.packages = guiApps ++ cliApps;
}
