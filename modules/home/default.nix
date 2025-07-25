{
  inputs,
  osConfig,
  pkgs,
  config,
  lib,
  ...
}:

let
  guiApps = with pkgs; [
    blanket
    blender
    discord
    gimp3
    gnome-frog
    libreoffice
    obs-studio
    teams-for-linux
    deluge-gtk
  ];
  cliApps = with pkgs; [
    direnv
    file
    lazygit
    p7zip-rar
    ripgrep
    tree
    unzip
    wget
    wl-clipboard
    zip
  ];
in
{
  imports = [
    ./bash.nix
    ./emacs
    ./ghostty.nix
    ./gnome.nix
    ./neovim
    ./ptyxis
    ./syncthing.nix
    ./tmux.nix
  ];

  home.username = "${osConfig.main-user.userName}";
  home.homeDirectory = "/home/${osConfig.main-user.userName}";
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName = "Chabam";
    userEmail = "fchabot1337@gmail.com";
    extraConfig = {
      merge = {
        tool = "nvim";
      };
      merge."nvim" = {
        cmd = "nvim -c 'DiffviewOpen'";
      };
      mergetool.prompt = false;
      push.autoSetupRemote = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  emacs.enable = true;

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash = {
      enable = true; # see note on other shells below
      enableVteIntegration = true;
    };
  };

  nix = {
    registry = {
      templates.flake = inputs.self;
    };
  };

  home = {
    shell.enableBashIntegration = true;

    # file = import ./autostart.nix {
    #   apps = with pkgs; [
    #   ];
    # };

    packages = guiApps ++ cliApps;

    sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT = 1;
      BROWSER = "firefox";
      PAGER = "less --use-color";
      SCRIPTS = "$HOME/.scripts";
      SCRIPTS_PRIVATE = "$HOME/.scripts/private";
      LOCAL_BIN = "$HOME/.local/bin/";
      PATH = "$PATH:$SCRIPTS:$SCRIPTS_PRIVATE";
      NIXCONF = "$HOME/Sources/nixos-config/";
    };
  };
}
