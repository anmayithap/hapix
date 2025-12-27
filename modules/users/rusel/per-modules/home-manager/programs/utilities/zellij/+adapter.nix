# =========================================================================
# == USER PROFILE: rusel (Terminal Multiplexer Adapter - Zellij)
# This module integrates 'Zellij' into the Zsh environment. It
# establishes a convenient alias for rapid session management,
# providing a modern, Rust-powered terminal workspace experience
# across all managed platforms.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Shell Integration (Zsh)
    # -----------------------------------------------------------------------
    programs.zsh.shellAliases = {
      # ### Tool Shortcut (zj -> zellij)
      # We map the standard 'zellij' command to a minimalist 'zj' shortcut.
      #
      # Benefits:
      # - Efficiency: Provides a two-character entry point for starting
      #   or attaching to terminal workspaces.
      # - Reliability: By using '${lib.getExe config.zellij.package}', the
      #   alias points directly to the specific version in the Nix store,
      #   ensuring it remains functional regardless of path mutations.
      zj = "${lib.getExe config.programs.zellij.package}";
    };
  };
}
