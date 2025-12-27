# =========================================================================
# == USER PROFILE: rusel (Diff Pager - delta)
# This module enables 'delta', a high-performance terminal pager designed
# to make Git diffs and command-line outputs more readable through syntax
# highlighting, side-by-side views, and line-level color coding.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.delta = {
      # ### Core Activation
      # Force-enable 'delta' globally for the user.
      #
      # Using 'lib.mkForce' ensures that delta is used as the default
      # pager for Git operations, providing a vastly superior visual
      # experience compared to the standard 'less' or 'diff' pagers.
      enable = lib.mkForce true;
    };
  };
}
