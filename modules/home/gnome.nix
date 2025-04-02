{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Emoji typing
    ibus-with-plugins

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
    };
  };
}
