{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Emoji typing
    ibus-with-plugins
    gnome-software
    gnome-themes-extra

    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.fullscreen-avoider
    gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher
    gnomeExtensions.pip-on-top
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          blur-my-shell.extensionUuid
          caffeine.extensionUuid
          clipboard-indicator.extensionUuid
          fullscreen-avoider.extensionUuid
          legacy-gtk3-theme-scheme-auto-switcher.extensionUuid
          pip-on-top.extensionUuid
        ];
      };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [
          "caps:ctrl_modifier"
        ];
      };

      # Shell settings
      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
        show-battery-percentage = true;
      };

      "org/gnome/desktop/wm/keybindings" = {
        show-desktop = [ "<Super>d" ];
        switch-applications = [ "<Alt>Tab" ];
        switch-applications-backward = [ "<Shift><Alt>Tab" ];
        switch-group = [ "<Super>Tab" ];
        switch-group-backward = [ "<Shift><Super>Tab" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        next = [ "<Super>bracketright" ];
        play = [ "Pause" ];
        previous = [ "<Super>bracketleft" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Shift><Control>Escape";
        command = "gnome-system-monitor";
        name = "taskman";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        resize-with-right-button = true;
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };

      # Various Gnome apps settings
      "org/gnome/TextEditor" = {
        restore-session = false;
      };

      "org/gnome/calculator" = {
        show-thousands = true;
      };

      "org/gnome/gnome-system-monitor" = {
        cpu-stacked-area-chart = true;
      };

      # Extensions settings
      "org/gnome/shell/extensions/pip-on-top" = {
        stick = true;
      };

    };
  };
}
