# =========================================================================
# == USER PROFILE: rusel (Python Tooling Integration - uv)
# This module integrates 'uv' (high-performance Python packager) into the
# Zsh environment. It ensures that 'uvx' (tool runner) has native shell
# completions enabled for a fluid interactive development experience.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh = {
      # -----------------------------------------------------------------------
      # ## Shell Completion Initialization
      # -----------------------------------------------------------------------
      # We use 'initContent' to inject the dynamic completion script for 'uv'.
      #
      # Using lib.mkOrder 1000 ensures this evaluation happens after the
      # core Zsh environment is ready but before specific user overrides.
      initContent = lib.mkOrder 1000 ''
        # ### uvx Completions
        # Dynamically generate and source completions for 'uvx'.
        # Since 'uv' is written in Rust and extremely fast, executing this
        # during shell startup provides instant completion with minimal
        # impact on latency.
        eval "$(${lib.getExe pkgs.uv}x --generate-shell-completion zsh)"
      '';
    };
  };
}
