{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    fish
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # Required
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

  home.file = {
    ".config/fish/conf.d/load-fzf-key-bindings.fish".text = "";
  };
}
