{ pkgs, ... }:

let
  root = ../.;
  modules = "${root}/modules/home";
in
{

  imports = [
    "${modules}/common-pkgs.nix"
    "${modules}/bash.nix"
    "${modules}/ghostty.nix"
    "${modules}/gnome.nix"
    "${modules}/neovim"
    "${modules}/tmux.nix"
  ];

  home.username = "chaf2717";
  home.homeDirectory = "/home/chaf2717";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

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

  home = {
    shell.enableShellIntegration = true;

    sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT = 1;
      BROWSER = "firefox";
      EDITOR = "nvim";
      SHELL = "bash";
      PAGER = "less --use-color";
      SCRIPTS = "$HOME/.scripts";
      SCRIPTS_PRIVATE = "$HOME/.scripts/private";
      RUST_BIN = "$HOME/.cargo/bin";
      LOCAL_BIN = "$HOME/.local/bin/";
      PATH = "$PATH:$SCRIPTS:$SCRIPTS_PRIVATE:$RUST_BIN:$LOCAL_BIN";
    };
  };
  programs.home-manager.enable = true;
}
