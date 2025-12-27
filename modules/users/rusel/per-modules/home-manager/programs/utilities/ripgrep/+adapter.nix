# =========================================================================
# == USER PROFILE: rusel (Search Utility Adapter - ripgrep)
# This module integrates 'ripgrep' into the Zsh environment. It establishes
# a convenient alias that replaces the legacy 'grep' command with a
# modern, recursive, and significantly faster search utility.
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
      # ### Tool Redirection (grep -> rg)
      # Replaces the standard GNU/BSD grep with ripgrep (rg).
      #
      # Benefits:
      # - Performance: Ripgrep is world-class in search speed, written in Rust.
      # - Smart Defaults: Automatically respects .gitignore and skips hidden
      #   files/binary data without extra flags.
      # - Reliability: Uses '${lib.getExe pkgs.ripgrep}' to ensure the alias
      #   points directly to the Nix-managed binary, bypassing any stale
      #   system paths.
      grep = "${lib.getExe pkgs.ripgrep}";
    };
  };
}
