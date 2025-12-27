# =========================================================================
# == USER PROFILE: rusel (Development Environment - direnv)
# This module optimizes the 'direnv' experience for the "rusel" user.
# It integrates nix-direnv for flake caching, mise for tool management,
# and enforces a silent, automated workflow within trusted directories.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    # Use unified identity for path resolution.
    inherit (config.user-meta) homeDirectory;
  in {
    programs.direnv = {
      # ### Core Activation
      # Enforce direnv as the primary environment switcher.
      enable = lib.mkForce true;

      # ### UI Noise Reduction
      # Suppress "direnv: loading..." messages for a cleaner terminal.
      silent = lib.mkForce true;

      # ### Security & Automation (Whitelist)
      # Automatically authorize any .envrc files found within the
      # ~/dev tree. This eliminates the need for manual 'direnv allow'
      # in primary development workspace.
      config = {
        whitelist = {
          prefix = ["${homeDirectory}/dev"];
        };
      };

      # -------------------------------------------------------------------
      # ## Integration Plugins
      # -------------------------------------------------------------------

      # ### mise-en-place
      # Bridges direnv with 'mise' to manage legacy language runtimes
      # (Node, Ruby, Python versions) alongside Nix environments.
      mise.enable = lib.mkForce true;

      # ### nix-direnv
      # Provides high-performance caching for Nix Flakes.
      # Prevents re-evaluating the entire devShell on every directory entry.
      nix-direnv.enable = lib.mkForce true;
    };
  };
}
