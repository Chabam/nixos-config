{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  home.file = {
    ".config/ghostty/config".text = ''
      font-family = "IosevkaTerm Nerd Font"
      font-size = 12
      font-feature = -calt, -liga, -dlig

      theme = light:chabam-light,dark:chabam-dark
      selection-invert-fg-bg = true

      mouse-hide-while-typing = true
      command = fish
      shell-integration = fish

      shell-integration-features = no-cursor

      window-padding-x = 10
      window-padding-y = 10
      keybind = alt+1=unbind
      keybind = alt+2=unbind
      keybind = alt+3=unbind
      keybind = alt+4=unbind
      keybind = alt+5=unbind
      keybind = alt+6=unbind
      keybind = alt+7=unbind
      keybind = alt+8=unbind
      keybind = alt+9=unbind
      keybind = alt+0=unbind

      keybind = ctrl+equal=reset_font_size
      keybind = ctrl+shift+physical:equal=increase_font_size:1
    '';
    ".config/ghostty/themes/chabam-light".text = ''
        # So far it's just Adwaita
        palette = 0=#241f31
        palette = 1=#c01c28
        palette = 2=#2ec27e
        palette = 3=#f5c211
        palette = 4=#1e78e4
        palette = 5=#9841bb
        palette = 6=#0ab9dc
        palette = 7=#c0bfbc
        palette = 8=#5e5c64
        palette = 9=#ed333b
        palette = 10=#57e389
        palette = 11=#f8e45c
        palette = 12=#51a1ff
        palette = 13=#c061cb
        palette = 14=#4fd2fd
        palette = 15=#f6f5f4
        background = #ffffff
        foreground = #000000
        cursor-color = #000000
        selection-background = #c0bfbc
        selection-foreground = #000000
    '';
    ".config/ghostty/themes/chabam-dark".text = ''
        palette = 0=#241f31
        palette = 1=#c01c28
        palette = 2=#2ec27e
        palette = 3=#f5c211
        palette = 4=#1e78e4
        palette = 5=#9841bb
        palette = 6=#0ab9dc
        palette = 7=#c0bfbc
        palette = 8=#5e5c64
        palette = 9=#ed333b
        palette = 10=#57e389
        palette = 11=#f8e45c
        palette = 12=#51a1ff
        palette = 13=#c061cb
        palette = 14=#4fd2fd
        palette = 15=#f6f5f4
        background = #161616
        foreground = #ffffff
        cursor-color = #ffffff
        selection-background = #ffffff
        selection-foreground = #5e5c64
    '';
  };
}
