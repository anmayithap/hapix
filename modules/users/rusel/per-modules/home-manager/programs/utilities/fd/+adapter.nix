# =========================================================================
# == USER PROFILE: rusel (Search Utility Adapter - fd)
# This module integrates 'fd' (a simple, fast alternative to 'find') into
# the interactive workflow. It configures 'fd' as the backend for FZF
# filtering and establishes intuitive shell aliases for file and
# directory discovery.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    # Retrieve the absolute path to the fd binary from the current config.
    fd = lib.getExe config.programs.fd.package;

    # Pre-defined commands for common search types.
    # Using 'fd' ensures that .git directories and hidden files (matching
    # .gitignore rules) are automatically excluded from results.
    fdFileCommand = "${fd} --type f";
    fdDirCommand = "${fd} --type d";
  in {
    # -----------------------------------------------------------------------
    # ## Filter Integration (FZF)
    # -----------------------------------------------------------------------
    # We replace the default find-based logic in FZF with 'fd' for
    # significant performance gains and smarter filtering.
    programs.fzf = {
      # Use fd for the general interactive search.
      defaultCommand = lib.mkForce fdFileCommand;

      # Use fd specifically for the File Widget (Ctrl+T).
      fileWidgetCommand = lib.mkForce fdFileCommand;

      # Use fd specifically for the Change Directory Widget (Alt+C).
      changeDirWidgetCommand = lib.mkForce fdDirCommand;
    };

    # -----------------------------------------------------------------------
    # ## Shell Integration (Zsh Aliases)
    # -----------------------------------------------------------------------
    programs.zsh.shellAliases = {
      # ### Tool Redirection
      # Replaces the legacy 'find' command with 'fd'.
      # While not 100% flag-compatible, it provides a much more
      # human-friendly interface for day-to-day searches.
      find = "${fd}";

      # ### Short-hand Search Utilities
      # Rapidly search only for files.
      fdf = "${fdFileCommand}";

      # Rapidly search only for directories.
      fdd = "${fdDirCommand}";
    };
  };
}
