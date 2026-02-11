# ----------------------------------------------------------------------------
# ## Home Manager Module: Configures zsh history ignore errors hook
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zsh = {lib, ...}: let
    mkLastConfiguration = lib.mkOrder 1500;
  in {
    programs.zsh.initContent = mkLastConfiguration ''
      function zsh_history_ignore_errors() {
          local exit_code=$?

          if [[ $exit_code -eq 130 ]]; then
              return
          fi

          if [[ $exit_code -ne 0 && $HISTCMD -gt 0 ]]; then
              builtin history -d -1 >/dev/null 2>&1
          fi
      }

      autoload -U add-zsh-hook
      add-zsh-hook precmd zsh_history_ignore_errors
    '';
  };
}
