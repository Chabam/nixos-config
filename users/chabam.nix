{ pkgs, ... }:

let root = ../.;
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

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
      wl-clipboard
      git
      lazygit
      wget
      tree
      ripgrep
      ranger
      nnn
      # TODO: Change when gimp3 is merged
      # gimp
      blender
      firefox
      discord
      teams-for-linux
  ];

  programs.git = {
      enable = true;
      userName = "Chabam";
      userEmail = "fchabot1337@gmail.com";
  };

  # Dirty hack to autostart some applications
  home.file = builtins.listToAttrs (map
    (pkg:
      {
        name = ".config/autostart/" + pkg.pname + ".desktop";
        value =
          if pkg ? desktopItem then {
            text = pkg.desktopItem.text;
          } else {
            source = (pkg + "/share/applications/" + pkg.pname + ".desktop");
          };
      })
    [ pkgs.discord pkgs.teams-for-linux ]);

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
