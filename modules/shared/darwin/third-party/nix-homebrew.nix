# =========================================================================
# == SHARED DARWIN MODULE: nix-homebrew (Declarative Taps)
# This module configures the nix-homebrew integration. It ensures that
# Homebrew taps are managed as immutable Nix flake inputs, preventing
# imperative drift and ensuring that the Homebrew environment is
# reproducible across different system generations.
# =========================================================================
{inputs, ...}: let
  # -----------------------------------------------------------------------
  # ## nix-homebrew Logic Definition
  # -----------------------------------------------------------------------
  nix-homebrew = {
    lib,
    config,
    ...
  }: let
    # We reference the standard homebrew configuration to ensure
    # nix-homebrew only activates if the main Homebrew service is enabled.
    inherit (config) homebrew;
  in {
    nix-homebrew = {
      # ### Activation
      # Automatically enable nix-homebrew if the parent Homebrew service
      # is active. This ensures the declarative layer is present only
      # when Homebrew itself is required.
      enable = lib.optionalAttrs homebrew.enable true;

      # ### Declarative Taps
      # We map our flake inputs directly to Homebrew's internal tap
      # structure. This allows Nix to download the tap metadata and
      # provide it to Homebrew as a read-only source.
      taps = {
        # 'homebrew-core' provides the primary CLI formulae.
        "homebrew/homebrew-core" = lib.mkDefault inputs.homebrew-core;

        # 'homebrew-cask' provides the primary macOS GUI applications.
        "homebrew/homebrew-cask" = lib.mkDefault inputs.homebrew-cask;
      };

      # ### Immutability (Purity)
      # We disable mutable taps by default. This is a critical security
      # and stability setting: it prevents the 'brew tap' command from
      # being used manually, ensuring that the system state always
      # matches the Nix declaration.
      mutableTaps = lib.mkDefault false;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the nix-homebrew orchestration into the Darwin registry.
  # This serves as the bridge between macOS third-party packages and
  # the pure, declarative world of Nix Flakes.
  flake.modules.darwin = {
    inherit nix-homebrew;
  };
}
