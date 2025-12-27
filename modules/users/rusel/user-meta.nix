# =========================================================================
# == USER PROFILE: Ruslan Torbeev (rusel)
# This module defines the personal identity and environment metadata for
# the primary user "rusel". It populates the shared user-meta schema,
# providing a single source of truth for name, email, and platform-specific
# home directory paths.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## User Metadata Implementation
  # -----------------------------------------------------------------------
  user-meta = {
    lib,
    pkgs,
    ...
  }: {
    user-meta = {
      # ### System Identity
      # The canonical login name used across all systems.
      username = lib.mkDefault "rusel";

      # ### Personal Details
      # These fields are used for Git commits, system descriptions,
      # and other user-facing metadata.
      name = lib.mkDefault "Ruslan";
      surname = lib.mkDefault "Torbeev";
      fullname = lib.mkDefault "Ruslan Torbeev";

      # Primary contact email used for global Git configuration.
      email = lib.mkDefault "ruslan.torbeev@yandex.ru";

      # ### Dynamic Environment Path
      # We calculate the home directory path at evaluation time.
      # - macOS (Darwin) typically uses '/Users/<username>'
      # - Linux (NixOS/WSL) typically uses '/home/<username>'
      homeDirectory = lib.mkDefault (
        if pkgs.stdenvNoCC.isDarwin
        then "/Users/rusel"
        else "/home/rusel"
      );
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # We register this identity profile into the specific platform registries.
  # This allows a host (e.g., 'maple') to simply import
  # 'inputs.self.modules.darwin.rusel' to initialize the user environment.
  flake.modules = {
    # macOS Registry
    darwin.rusel.imports = [user-meta];

    # NixOS (Linux/WSL) Registry
    nixos.rusel.imports = [user-meta];

    # Standalone Home Manager Registry
    homeManager.rusel.imports = [user-meta];
  };
}
