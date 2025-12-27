# =========================================================================
# == USER PROFILE: rusel (Disk Usage Adapter - duf)
# This module integrates 'duf' into the Zsh environment. It establishes
# a convenient alias that replaces the legacy 'df' command with a
# modern, user-friendly, and colorized disk usage analyzer.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Shell Integration (Zsh)
    # -----------------------------------------------------------------------
    programs.zsh.shellAliases = {
      # ### Tool Redirection (df -> duf)
      # Replaces the standard Unix 'disk free' command with duf.
      #
      # Benefits:
      # - Readability: Provides clear, tabulated data with bar graphs.
      # - Intelligence: Automatically groups and filters filesystems
      #   (hiding pseudo and duplicate filesystems by default).
      # - Reliability: Uses '${lib.getExe pkgs.duf}' to point directly to
      #    the Nix-managed binary, ensuring the alias works regardless
      #    of the global $PATH state.
      df = "${lib.getExe pkgs.duf}";
    };
  };
}
