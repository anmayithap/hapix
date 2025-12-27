# =========================================================================
# == USER PROFILE: rusel (System Integration)
# This module performs the low-level registration of the "rusel" user
# account across both macOS and NixOS. It bridges the shared 'user-meta'
# identity with the respective OS-level user management systems,
# ensuring consistent UIDs, home paths, and permissions.
# =========================================================================
{inputs, ...}: let
  # -----------------------------------------------------------------------
  # ## System User Logic
  # -----------------------------------------------------------------------
  user = {
    lib,
    config,
    ...
  }: let
    # We extract the identity details from our custom metadata schema.
    # This ensures that if the username or home path changes in the
    # identity module, the system account updates automatically.
    inherit (config.user-meta) username fullname homeDirectory;
  in {
    users.users.${username} = {
      # ### Account Identity
      # We use 'lib.mkForce' to ensure our declarative metadata takes
      # absolute precedence over any other module defaults.
      name = lib.mkForce username;
      description = lib.mkForce fullname;

      # ### Environment Path
      # Maps the home directory to the path calculated in 'user-meta.nix'.
      # On macOS, this is typically /Users/rusel.
      home = homeDirectory;

      # ### Initialization
      # Ensures that nix-darwin handles the creation of the home
      # directory if it is missing during the first activation.
      createHome = lib.mkForce true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # We register the "rusel" account logic into both platform registries.
  # This allows hosts like 'maple' (Darwin) or any future NixOS hosts
  # to inherit the correct user account structure.
  flake.modules = {
    # macOS Configuration
    darwin.rusel.imports = [
      inputs.self.modules.darwin.user-meta

      user
    ];

    # NixOS / WSL Configuration
    nixos.rusel.imports = [
      inputs.self.modules.nixos.user-meta

      user
    ];
  };
}
