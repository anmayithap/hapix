# =========================================================================
# == USER PROFILE: rusel (Simplified Manuals - tealdeer)
# This module enables 'tealdeer', a high-performance implementation of
# the 'tldr' pages in Rust. It provides simplified, example-based
# documentation for CLI commands, serving as a rapid alternative to
# traditional, exhaustive man pages.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.tealdeer = {
      # ### Core Activation
      # Enable tealdeer globally for the user profile.
      #
      # We use 'lib.mkDefault' to ensure this documentation tool is
      # available across the "rusel" environment while allowing
      # host-specific exclusions if necessary.
      enable = lib.mkDefault true;

      # Note: tealdeer handles the automatic fetching and caching of
      # tldr-pages. Standard shell integration (aliasing 'tldr' and
      # 'tl' to the tealdeer binary) is managed by the corresponding
      # 'tldr/+adapter.nix' module.
    };
  };
}
