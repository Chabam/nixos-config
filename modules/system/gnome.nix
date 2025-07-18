{ pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    atomix # puzzle game
    epiphany # web browser
    geary # email reader
    gnome-music
    gnome-photos
    gnome-terminal
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ];

  environment.systemPackages = with pkgs; [
    decibels
  ];
}
