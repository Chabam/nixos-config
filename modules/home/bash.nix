{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gitstatus
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyIgnore = [ "l" "ls" "cd" "exit" ];
    historyControl = [ "erasedups" ];
    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
    };
    initExtra =
    # Bash
      ''
      source ${pkgs.gitstatus}/share/gitstatus/gitstatus.plugin.sh
      gitstatus_stop && gitstatus_start -s -1 -u -1 -c -1 -d -1 -m -1
      PROMPT_COMMAND=__prompt_command

      if [[ -n "$IN_NIX_SHELL" ]] && [[ -z $ORIG_SHLVL ]] then
        export ORIG_SHLVL=$SHLVL
      fi

      __prompt_command() {
        EXIT_CODE=$?
        CLEAR="\[\e[0m\]"
        RED="\[\e[1;31m\]"
        GREEN="\[\e[1;32m\]"
        YELLOW="\[\e[1;33m\]"
        BLUE="\[\e[1;34m\]"
        CYAN="\[\e[1;36m\]"
        PURPLE="\[\e[0;35m\]"


        PS1=""
        NNN_INFO=""
        if [[ $NNNLVL -ge 1 ]]; then
          NNN_INFO="$PURPLE(NNN"
          if [[ $NNNLVL -ge 2 ]]; then
            NNN_INFO+=" +$(( $NNNLVL - 1))"
          fi
          NNN_INFO+=") $CLEAR"
        fi
        PS1+=$NNN_INFO

        NIX_SHELL_INFO=""
        if [[ -n "$IN_NIX_SHELL" ]]; then
          NIX_SHELL_INFO="$CYAN<nix-shell"
          ACTUAL_SHELL_LVL=$(($SHLVL - $ORIG_SHLVL))
          if [[ $ACTUAL_SHELL_LVL -ge 1 ]]; then
            NIX_SHELL_INFO+=" +$ACTUAL_SHELL_LVL"
          fi
          NIX_SHELL_INFO+="> $CLEAR"
        fi

        PS1+="$NIX_SHELL_INFO$GREEN\u$CLEAR@"

        HOST_COLOR=""
        if [[ $SSH_TTY ]]; then
          HOST_COLOR=$YELLOW
        else
          HOST_COLOR=$CLEAR
        fi

        PS1+="$HOST_COLOR\h $BLUE\w"

        GIT_INFO=""
        if gitstatus_query && [[ "$VCS_STATUS_RESULT" == ok-sync ]]; then
          GIT_INFO+=" $CLEAR("
          if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
            GIT_INFO+="$GREEN$VCS_STATUS_LOCAL_BRANCH"
            if [[ $VCS_STATUS_COMMITS_AHEAD -ge 1 ]]; then
              GIT_INFO+="⇡$VCS_STATUS_COMMITS_AHEAD"
            fi
            if [[ $VCS_STATUS_COMMITS_BEHIND -ge 1 ]]; then
              GIT_INFO+="⇣$VCS_STATUS_COMMITS_BEHIND"
            fi
          elif [[ $VCS_STATUS_TAG != "" ]]; then
            GIT_INFO+="$GREEN$VCS_STATUS_TAG"
          else
            GIT_INFO+="$GREEN$VCS_STATUS_COMMIT"
          fi

          GIT_INFO+="$CLEAR|"

          if [[ $VCS_STATUS_HAS_STAGED -eq 1 ]] ||
             [[ $VCS_STATUS_HAS_UNSTAGED -eq 1 ]] ||
             [[ $VCS_STATUS_HAS_CONFLICTED -eq 1 ]] ||
             [[ $VCS_STATUS_HAS_UNTRACKED -eq 1 ]]; then

            if [[ $VCS_STATUS_NUM_CONFLICTED -ge 1 ]]; then
              GIT_INFO+="$PURPLE$VCS_STATUS_ACTION~$VCS_STATUS_NUM_STAGED_NEW$CLEAR"
            fi

            if [[ $VCS_STATUS_NUM_STAGED_NEW -ge 1 ]]; then
              GIT_INFO+="$GREEN+$VCS_STATUS_NUM_STAGED_NEW$CLEAR"
            fi

            if [[ $VCS_STATUS_NUM_STAGED_DELETED -ge 1 ]]; then
              GIT_INFO+="$RED-$VCS_STATUS_NUM_STAGED_DELETED$CLEAR"
            fi

            if [[ $VCS_STATUS_NUM_STAGED -ge 1 ]]; then
              NUM_MODIFIED=$(($VCS_STATUS_NUM_STAGED - $VCS_STATUS_NUM_STAGED_NEW - $VCS_STATUS_NUM_STAGED_DELETED))
              GIT_INFO+="$BLUE~$NUM_MODIFIED$CLEAR"
            fi

            (( $VCS_STATUS_HAS_UNSTAGED  )) && GIT_INFO+="$YELLOW!$VCS_STATUS_NUM_UNSTAGED$CLEAR"
            (( $VCS_STATUS_HAS_UNTRACKED )) && GIT_INFO+="$CYAN?$VCS_STATUS_NUM_UNTRACKED$CLEAR"
          else
            GIT_INFO+="✔"
          fi
          GIT_INFO+="$CLEAR)"
        fi

        PS1+=$GIT_INFO

        EXIT_STATUS_COLOR=""
        if [[ $EXIT_CODE -eq 0 ]]; then
          EXIT_STATUS_COLOR=$GREEN
        else
          EXIT_STATUS_COLOR=" $RED[$EXIT_CODE]"
        fi

        PS1+="$EXIT_STATUS_COLOR\n\$$CLEAR "
      }

      force_color_prompt=yes

      # Disable Ctrl+S behavior
      stty -ixon
    '';
  };

  home.file = {
    ".inputrc".text = ''
      TAB: menu-complete
      "\e[Z": menu-complete-backward
      "\e[1;5c": forward-word
      "\e[1;5d": backward-word
      "\e[A": history-search-backward
      "\e[B": history-search-forward

      set show-all-if-ambiguous on
      set menu-complete-display-prefix on
      set completion-ignore-case on
      set colored-stats on
      set colored-completion-prefix on
    '';
  };
}
