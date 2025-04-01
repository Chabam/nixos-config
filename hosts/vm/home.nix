{ config, pkgs, inputs, ... }:

{
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
  home.packages = [
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

  programs.fzf = {
    enableFishIntegration = false;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      source $HOME/.config/fish/functions/notify_vte_preexec.fish
      source $HOME/.config/fish/functions/notify_vte_precmd.fish
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
    prefix = "C-q";
    plugins = with pkgs; [
      tmuxPlugins.yank
      { plugin = inputs.minimal-tmux.packages.${pkgs.system}.default; }
    ];
  };



  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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

  programs.git = {
      enable = true;
      userName = "Chabam";
      userEmail = "fchabot1337@gmail.com";
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
    EDITOR = "nvim";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
