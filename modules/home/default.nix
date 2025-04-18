{
  inputs,
  osConfig,
  pkgs,
  ...
}:

let
  guiApps = with pkgs; [
    discord
    firefox
    teams-for-linux
    libreoffice
  ];
  cliApps = with pkgs; [
    git
    lazygit
    nnn
    ripgrep
    tree
    wget
    wl-clipboard
    direnv
  ];
in
{
  imports = [
    ./bash.nix
    ./ghostty.nix
    ./gnome.nix
    ./neovim
    ./ptyxis
    ./syncthing.nix
    ./tmux.nix
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  home.username = "${osConfig.main-user.userName}";
  home.homeDirectory = "/home/${osConfig.main-user.userName}";
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName = "Chabam";
    userEmail = "fchabot1337@gmail.com";
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  home.file = import ./autostart.nix {
    apps = with pkgs; [
      teams-for-linux
      discord
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
  };

  home = {
    shell.enableShellIntegration = true;

    packages = guiApps ++ cliApps;

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
