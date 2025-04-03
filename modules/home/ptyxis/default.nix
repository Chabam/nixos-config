{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ptyxis
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/Ptyxis" = {
        audible-bell = false;
        default-profile-uuid = "778c8e65cdfbb9562393693c677c200c";
        font-name = "IosevkaTerm Nerd Font 12";
        interface-style = "system";
        profile-uuids = [ "778c8e65cdfbb9562393693c677c200c" ];
        use-system-font = false;
      };

      "org/gnome/Ptyxis/Profiles/778c8e65cdfbb9562393693c677c200c" = {
        bold-is-bright = true;
        label = "Chabam";
        limit-scrollback = false;
        use-custom-command = true;
        custom-command = "fish";
        palette = "chabam";
      };

      "org/gnome/Ptyxis/Shortcuts" = {
        focus-tab-1 = "";
        focus-tab-10 = "";
        focus-tab-2 = "";
        focus-tab-3 = "";
        focus-tab-4 = "";
        focus-tab-5 = "";
        focus-tab-6 = "";
        focus-tab-7 = "";
        focus-tab-8 = "";
        focus-tab-9 = "";
        preferences = "";
        primary-menu = "";
        toggle-fullscreen = "";
      };
    };
  };

  home.file = {
    ".local/share/org.gnome.Ptyxis/palettes/chabam.palette".source = ./chabam.palette;
    ".local/share/applications/org.gnome.Ptyxis.desktop".source = ./org.gnome.Ptyxis.desktop;
    ".local/share/icons/hicolor/scalable/apps/org.gnome.Ptyxis.svg".source = ./org.gnome.Ptyxis.svg;
    ".local/share/icons/hicolor/symbolic/apps/org.gnome.Ptyxis-symbolic.svg".source =
      ./org.gnome.Ptyxis-symbolic.svg;
  };
}
