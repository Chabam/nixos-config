{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  home.packages = with pkgs; [
    # Emoji typing
    ibus-with-plugins
    gnome-software
    gnome-themes-extra

    gnomeExtensions.appindicator
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
          caffeine.extensionUuid
          clipboard-indicator.extensionUuid
          fullscreen-avoider.extensionUuid
          legacy-gtk3-theme-scheme-auto-switcher.extensionUuid
          pip-on-top.extensionUuid
        ];
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
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

      "org/gnome/Console" = {
        audible-bell = false;
        custom-font = "IosevkaTerm Nerd Font Mono 12";
        ignore-scrollback = true;
        theme = "auto";
        use-system = false;
      };
    };
  };

  # Setting default text editor to Gnome's text editor
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = [ "org.gnome.TextEditor.desktop" ];

      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
      "image/tiff" = [ "org.gnome.Loupe.desktop" ];
      "image/x-tga" = [ "org.gnome.Loupe.desktop" ];
      "image/vnd-ms.dds" = [ "org.gnome.Loupe.desktop" ];
      "image/x-dds" = [ "org.gnome.Loupe.desktop" ];
      "image/bmp" = [ "org.gnome.Loupe.desktop" ];
      "image/vnd.microsoft.icon" = [ "org.gnome.Loupe.desktop" ];
      "image/vnd.radiance" = [ "org.gnome.Loupe.desktop" ];
      "image/x-exr" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-bitmap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-graymap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-pixmap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-portable-anymap" = [ "org.gnome.Loupe.desktop" ];
      "image/x-qoi" = [ "org.gnome.Loupe.desktop" ];
      "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
      "image/svg+xml-compressed" = [ "org.gnome.Loupe.desktop" ];
      "image/avif" = [ "org.gnome.Loupe.desktop" ];
      "image/heic" = [ "org.gnome.Loupe.desktop" ];
      "image/jxl" = [ "org.gnome.Loupe.desktop" ];
    };
  };

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    x11.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita";
      package = pkgs.adwaita-qt;
    };
  };
}
