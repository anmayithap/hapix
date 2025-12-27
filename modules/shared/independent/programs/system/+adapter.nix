# =========================================================================
# == SHARED MODULE: System Environment & Shell Aliases
# This module defines global environment settings for all interactive
# shells. It focuses on providing a consistent CLI experience by
# establishing high-level aliases for system management tools across
# both Darwin and NixOS platforms.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Environment Logic Definition
  # -----------------------------------------------------------------------
  # This block configures the shell environment. Settings defined here
  # apply to all users and all interactive shells (Zsh, Bash, Fish).
  environment = {
    lib,
    pkgs,
    ...
  }: {
    environment = {
      # ### Shell Aliases
      # These shortcuts reduce typing overhead for frequently used commands.
      shellAliases = {
        # #### nixh (Nix Helper Alias)
        # We map 'nixh' to the absolute path of the 'nh' binary.
        #
        # Using `${lib.getExe pkgs.nh}` is a security and reliability
        # best practice: it points directly to the specific version in
        # the Nix store, ensuring the alias remains functional even if
        # the PATH is restricted or 'nh' is not explicitly installed
        # in the user's profile.
        nixh = "${lib.getExe pkgs.nh}";

        # #### nhc (Nix Clean)
        # Performs a safe cleanup of old system and home-manager generations.
        #
        # By default, this will:
        # 1. Remove generations older than 30 days (default nh behavior).
        # 2. Clean up the user's home-manager generations.
        # 3. Optimize the nix store by hardlinking duplicates.
        nhc = "${lib.getExe pkgs.nh} clean all";

        # #### nhca (Nix Clean Aggressive)
        # A more aggressive cleanup that keeps only the most recent
        # generations. Useful when disk space is low.
        #
        # '--keep 3' ensures that only the last 3 successful
        # generations are preserved, allowing for safe rollbacks
        # while purging everything else.
        nhca = "${lib.getExe pkgs.nh} clean all --keep 3";

        # 'nixs' (Nix Search): High-speed interactive package search.
        nhs = "${lib.getExe pkgs.nh} search";
      };
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the environment configuration into both the Darwin and
  # NixOS registries. This ensures that the 'nixh' command behaves
  # identically whether you are on your MacBook or a Linux server.
  flake.modules = {
    # macOS Environment Registry
    darwin.environment = environment;

    # NixOS Environment Registry
    nixos.environment = environment;
  };
}
