# =========================================================================
# == USER PROFILE: rusel (Structured Data Processing - yq)
# This module installs 'yq', a portable command-line YAML, JSON, XML,
# CSV, TOML, and properties processor. It serves as the primary engine
# for inspecting and manipulating structured configuration files
# directly from the terminal.
# =========================================================================
{
  flake.modules.homeManager.rusel = {pkgs, ...}: {
    # -----------------------------------------------------------------------
    # ## User Packages
    # -----------------------------------------------------------------------
    home.packages = with pkgs; [
      # ### yq (The "jq" for everything)
      # A versatile data processing tool that features:
      # - Superset of 'jq' logic applied to YAML and other formats.
      # - Deep path expression support for complex nested structures.
      # - High performance and zero dependencies beyond the binary.
      #
      # Installing this via 'home.packages' ensures the CLI tool is
      # available across both Darwin and NixOS workstations.
      yq
    ];
  };
}
