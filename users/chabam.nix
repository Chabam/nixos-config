{ pkgs, ... }:

let
  root = ../.;
  modules = "${root}/modules/home";
in
{

  imports = [
    "${modules}/common-pkgs.nix"
    "${modules}/fish.nix"
    "${modules}/ghostty.nix"
    "${modules}/gnome.nix"
    "${modules}/neovim"
    "${modules}/syncthing.nix"
    "${modules}/tmux.nix"
  ];

  home.username = "chabam";
  home.homeDirectory = "/home/chabam";
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName = "Chabam";
    userEmail = "fchabot1337@gmail.com";
  };

  home.file = import "${modules}/autostart.nix" {
    apps = with pkgs; [
      teams-for-linux
      discord
    ];
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    SHELL = "fish";
    PAGER = "less --use-color";
    SCRIPTS = "$HOME/.scripts";
    SCRIPTS_PRIVATE = "$HOME/.scripts/private";
    RUST_BIN = "$HOME/.cargo/bin";
    LOCAL_BIN = "$HOME/.local/bin/";
    PATH = "$PATH:$SCRIPTS:$SCRIPTS_PRIVATE:$RUST_BIN:$LOCAL_BIN";
  };

  programs.home-manager.enable = true;
}
