# =========================================================================
# == USER PROFILE: rusel (Utility Adapter - bat)
# This module integrates 'bat' (a cat clone with wings) into the shell
# environment and interactive filters. It provides enhanced visual
# previews for file browsing and command history navigation.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs = {
      # -----------------------------------------------------------------------
      # ## Shell Integration (Zsh)
      # -----------------------------------------------------------------------
      zsh = {
        shellAliases = {
          # ### Standard Tool Wrap
          # Replaces the legacy 'cat' command with 'bat'.
          # This provides syntax highlighting, line numbers, and git
          # integration by default for every file read in the terminal.
          cat = "${lib.getExe pkgs.bat}";
        };
      };

      # -----------------------------------------------------------------------
      # ## Filter Integration (FZF)
      # -----------------------------------------------------------------------
      # Configures fzf to use 'bat' as the high-performance preview engine
      # for interactive widgets.
      fzf = {
        # ### File Widget Preview
        # Triggers when using Ctrl+T to find files.
        # Shows the first 500 lines of the selected file with syntax
        # highlighting and line numbers.
        fileWidgetOptions = [
          "--preview '${lib.getExe pkgs.bat} --style=numbers --color=always --line-range :500 {}'"
        ];

        # ### History Widget Preview
        # Triggers when using Ctrl+R to search shell history.
        # Renders the selected command as highlighted shell script,
        # making complex one-liners easier to read before execution.
        historyWidgetOptions = lib.mkAfter [
          "--preview 'echo {} | ${lib.getExe pkgs.bat} --language=sh --style=plain --color=always'"
        ];
      };
    };
  };
}
