{ config, pkgs, inputs, ... }:

let root = ../..;
    modules = "${root}/modules/home";
in {

  imports = [
    "${modules}/fish.nix"
    "${modules}/gnome.nix"
    "${modules}/neovim"
    "${modules}/ptyxis"
    "${modules}/tmux.nix"
  ];

  home.username = "chabam";
  home.homeDirectory = "/home/chabam";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
      wl-clipboard
      git
      lazygit
      wget
      tree
  ];

  programs.git = {
      enable = true;
      userName = "Chabam";
      userEmail = "fchabot1337@gmail.com";
  };

  home.sessionVariables = {
    BROWSER="firefox";
    EDITOR="nvim";
    PAGER="less --use-color";
    SCRIPTS="$HOME/.scripts";
    SCRIPTS_PRIVATE="$HOME/.scripts/private";
    RUST_BIN="$HOME/.cargo/bin";
    LOCAL_BIN="$HOME/.local/bin/";
    PATH="$PATH:$SCRIPTS:$SCRIPTS_PRIVATE:$RUST_BIN:$LOCAL_BIN";
  };

  programs.home-manager.enable = true;
}
