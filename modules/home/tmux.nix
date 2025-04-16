{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    shortcut = "q";
    terminal = "xterm-ghostty";
    escapeTime = 0;
    plugins = with pkgs; [
      tmuxPlugins.yank
      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig = ''
          set -g @minimal-tmux-fg "#161616"
          set -g @minimal-tmux-bg "#2ec27e"
        '';
      }
    ];

    extraConfig = ''
      set-option -g default-command ${pkgs.bash}/bin/bash

      # Vim style bindings
      bind-key v split-window -h
      bind-key s split-window -v
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key a last-pane
      bind-key q display-panes
      bind-key c new-window
      bind-key t next-window
      bind-key T previous-window

      bind-key [ copy-mode
      bind-key ] paste-buffer

      bind-key -T copy-mode-vi v send -X begin-selection

      # Undercurl support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set-option -g repeat-time 0
    '';
  };
}
