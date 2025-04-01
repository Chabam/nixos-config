{ config, pkgs, inputs, ... }:

let resources = ../../resources;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "chabam";
  home.homeDirectory = "/home/chabam";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
      # CLI
      fish
      git
      tmux
      neovim
      wget
      tree
      fzf
      ripgrep
      lazygit
      unzip

      # GUI
      ptyxis

      # Langs
      nodejs_23

      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.fullscreen-avoider
      gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher
      gnomeExtensions.pip-on-top
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "IosevkaTerm" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # Required
      source $HOME/.config/fish/functions/notify_vte_preexec.fish
      source $HOME/.config/fish/functions/notify_vte_precmd.fish

      # Disable fzf...
      bind --erase \cr
      bind -M insert --erase \cr

      bind --erase \ec
      bind -M insert --erase \ec
      bind \ec __fzf_cd

      bind --erase \eO
      bind -M insert --erase \eO
      bind \\f __fzf_open
    '';
    functions = {
      fish_prompt = {
        body = ''
          set -l last_status $status
          set -l normal (set_color normal)
          set -l status_color (set_color brgreen)
          set -l cwd_color (set_color brblue)
          set -l prompt_status ""
          set -l container_color (set_color brmagenta)
          set -g __fish_git_prompt_show_informative_status true
          set -g __fish_git_prompt_showcolorhints true
          set -g __fish_git_prompt_showuntrackedfiles true

          # Since we display the prompt on a new line allow the directory names to be longer.
          set -q fish_prompt_pwd_dir_length
          or set -lx fish_prompt_pwd_dir_length 0

          # Color the prompt differently when we're root
          set -l suffix '$'
          if functions -q fish_is_root_user; and fish_is_root_user
          if set -q fish_color_cwd_root
              set cwd_color (set_color $fish_color_cwd_root)
          end
          set suffix '#'
          end

          if string length --quiet $CONTAINER_ID
          set container_part "$container_color.$CONTAINER_ID"
          end

          # Color the prompt in red on error
          if test $last_status -ne 0
          set status_color (set_color $fish_color_error)
          set prompt_status $status_color "[" $last_status "]" $normal
          end

          echo -s (prompt_login) $container_part ' ' $cwd_color (prompt_pwd) $normal (fish_vcs_prompt) $normal ' ' $prompt_status
          echo -n -s $status_color $suffix ' ' $normal
    '';
      };

      send_vte_termprop_signal = {
        body = "printf \\e\\]666\\;%s!\\e\\\\ $argv";
      };

      notify_vte_preexec = {
        body = "send_vte_termprop_signal vte.shell.preexec";
        onEvent = "fish_preexec";
      };

      notify_vte_precmd = {
        body = "send_vte_termprop_signal vte.shell.precmd";
        onEvent = "fish_postexec";
      };
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    shortcut = "q";
    terminal = "xterm-256color";
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
      set-option -g default-command fish

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

      # Undercurl support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set-option -g repeat-time 0
    '';
  };

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
	custom-command ="fish";
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

  programs.git = {
      enable = true;
      userName = "Chabam";
      userEmail = "fchabot1337@gmail.com";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".local/share/org.gnome.Ptyxis/palettes/chabam.palette".source = "${resources}/ptyxis/chabam.palette";

    ".config/nvim" = {
      source = "${resources}/neovim";
      recursive = true;
    };

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/chabam/etc/profile.d/hm-session-vars.sh
  #
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


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
