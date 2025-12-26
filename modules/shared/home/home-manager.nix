# =========================================================================
# == SHARED HOME-MANAGER MODULE: Orchestration Settings
# This module defines the foundational behavior of Home Manager. It
# configures how user packages are integrated into the system, establishes
# safety protocols for file collisions, and enables detailed logging
# for troubleshooting environment transitions.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Home Manager Logic Definition
  # -----------------------------------------------------------------------
  home-manager = {lib, ...}: {
    home-manager = {
      # ### Package Management Strategy
      # We disable 'useGlobalPkgs' to maintain a clean separation between
      # system-level packages and user-level packages. This allows for
      # more granular control over package versions in the user profile.
      useGlobalPkgs = lib.mkDefault false;

      # We enable 'useUserPackages' to ensure that packages declared in
      # Home Manager are installed directly into the user's profile
      # (e.g., ~/.nix-profile), aligning with the standard Nix philosophy.
      useUserPackages = lib.mkDefault true;

      # ### Safety & Collision Handling
      # If Home Manager encounters an existing file (e.g., a manually
      # created .zshrc) that it wants to manage, it will automatically
      # rename the old file with this extension instead of failing.
      # This prevents "activation blocks" on new system installs.
      backupFileExtension = lib.mkDefault "home-manager.backup";

      # ### Diagnostics
      # Enable verbose output during 'home-manager switch' or system
      # rebuilds. This provides a clear audit trail of which files were
      # generated and which services were restarted.
      verbose = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # We "broadcast" this orchestration logic to all major platform
  # registries. This ensures that whether the system is macOS, native
  # NixOS, or a standalone Home Manager installation, the management
  # engine behaves identically.
  flake.modules = {
    # Standalone Home Manager registry.
    homeManager.home-manager = home-manager;

    # Integration registry for macOS.
    darwin.home-manager = home-manager;

    # Integration registry for Linux.
    nixos.home-manager = home-manager;
  };
}
