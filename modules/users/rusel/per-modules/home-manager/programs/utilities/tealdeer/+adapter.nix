# =========================================================================
# == USER PROFILE: rusel (Documentation Adapter - tldr/tealdeer)
# This module integrates 'tealdeer' (a high-performance tldr client) into
# the Zsh environment. It establishes convenient aliases for accessing
# simplified community-driven man pages, enabling rapid command recall
# through practical usage examples.
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
      # ### Tool Redirection (tldr -> tealdeer)
      # We map the standard 'tldr' command and a minimalist 'tl' shortcut
      # to the Rust-based 'tealdeer' binary.
      #
      # Benefits:
      # - Speed: tealdeer provides near-instant documentation lookups.
      # - Reliability: Uses '${lib.getExe pkgs.tealdeer}' to ensure the
      #   alias points directly to the Nix store path, maintaining
      #   functionality regardless of the global system PATH.
      tldr = "${lib.getExe pkgs.tealdeer}";
      tl = "${lib.getExe pkgs.tealdeer}";
    };
  };
}
