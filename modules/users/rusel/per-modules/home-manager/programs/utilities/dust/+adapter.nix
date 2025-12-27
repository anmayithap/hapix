# =========================================================================
# == USER PROFILE: rusel (Disk Analysis Adapter - dust)
# This module integrates 'dust' into the Zsh environment. It establishes
# a convenient alias that replaces the legacy 'du' command with a
# modern, tree-based, and visually intuitive disk usage analyzer.
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
      # ### Tool Redirection (du -> dust)
      # Replaces the standard Unix 'disk usage' command with dust.
      #
      # Benefits:
      # - Visual Hierarchy: Presents a tree-view of directories sorted by size.
      # - Information Density: Includes percentage bars and human-readable sizes.
      # - Reliability: Uses '${lib.getExe pkgs.dust}' to ensure the alias
      #   points directly to the immutable Nix store path.
      du = "${lib.getExe pkgs.dust}";
    };
  };
}
