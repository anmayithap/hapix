# =========================================================================
# == USER PROFILE: Nix Daemon User Access
# This module configures the security and permission layers of the Nix
# daemon. It grants the primary user authorized access to the Nix store
# and elevates them to 'trusted' status, allowing for advanced Nix
# operations and custom binary cache usage across Darwin and NixOS.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Nix User Logic Definition
  # -----------------------------------------------------------------------
  nix-settings = {
    lib,
    config,
    ...
  }: let
    # We extract the username from our unified identity profile.
    # This ensures permissions stay in sync with the user account.
    inherit (config.user-meta) username;
  in {
    nix.settings = {
      # ### Trusted Users
      # Users listed here have elevated privileges with the Nix daemon.
      # They can:
      # - Specify additional binary caches (substituters) via the CLI.
      # - Use 'nix run' and 'nix shell' with restricted settings.
      #
      # We use `lib.mkBefore` to ensure the user is added to the
      # front of the list, ensuring priority during evaluation.
      trusted-users = lib.mkBefore [
        username
      ];

      # ### Allowed Users
      # Defines who is permitted to connect to the Nix daemon.
      # By adding the primary user here, we ensure they can perform
      # standard package management tasks and system queries.
      allowed-users = lib.mkBefore [
        username
      ];
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # This registers the user-access logic into both the Darwin and NixOS
  # registries. This is a foundational step for enabling a seamless
  # developer experience (e.g., using 'nh' or 'nixh' without constant
  # password prompts for Nix-specific tasks).
  flake.modules = {
    darwin.nix-settings = nix-settings;
    nixos.nix-settings = nix-settings;
  };
}
