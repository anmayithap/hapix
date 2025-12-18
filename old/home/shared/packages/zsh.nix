{
  lib,
  config,
  ...
}: let
  histFile = "${config.custom.zsh.zdotdir}/.histfile";
in {
  custom.zsh = {
    enable = lib.mkDefault true;

    configFiles.".zshrc".fragments."zsh-history" = {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => CUSTOM HISTORY
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        HISTFILE=${histFile}
        HISTSIZE=50000
        SAVEHIST=50000
        setopt HIST_IGNORE_ALL_DUPS
        setopt INC_APPEND_HISTORY
        setopt EXTENDED_HISTORY
        setopt HIST_EXPIRE_DUPS_FIRST
        setopt HIST_FIND_NO_DUPS
        setopt HIST_IGNORE_SPACE
        setopt SHARE_HISTORY
        setopt HIST_REDUCE_BLANKS
        HISTORY_IGNORE='(vh)'

        # Create and open custom history file
        function vh {
            # Create a temporary file for initial processing
            temp_file=$(mktemp /tmp/histfile.XXXXXX)
            # Create a temporary file for viewing
            temp_view_file=$(mktemp /tmp/histfile_view.XXXXXX)

            # Process the history file using awk
            awk -F':' '
            # If line already starts with date-time format, print as is and move to next line
            /^[0-9]{2}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}/ { print; next }
            {
                # Extract command from third field
                cmd=$3
                # Remove leading "0;" if present
                sub(/^0;/, "", cmd)
                # Format timestamp to human-readable date
                date=strftime("%y-%m-%d %H:%M", $2)
                # Print formatted date and command
                print date "| " cmd
            }' ${histFile} > "$temp_file" && mv "$temp_file" "$temp_view_file"

            # Open processed history in vim for viewing
            vim "$temp_view_file"

            # Clean up temporary file after viewing
            rm "$temp_view_file"
        }
      '';
      order = 101;
    };

    configFiles.".zshrc".fragments."zsh-default-aliases" = {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => CUSTOM DEFAULT ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias zz='source $ZDOTDIR/.zshrc'
        alias cp='cp -r'
        alias mkd='mkdir -p'
        alias ngc='nix-collect-garbage -d && sudo nix-collect-garbage -d'
        alias nh='nix profile history --profile /nix/var/nix/profiles/system'
        alias nc='sudo nix profile wipe-history --profile /nix/var/nix/profiles/system'
        alias cl='clear'
        alias tl='tldr'
      '';
      order = 900;
    };
  };
}
