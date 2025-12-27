# =========================================================================
# == USER PROFILE: rusel (Homebrew Cask Customization)
# This module fine-tunes how Homebrew handles GUI applications (Casks).
# It prioritizes user-level isolation by redirecting installations to the
# home directory and enhances deployment reliability by relaxing strict
# checksum requirements for third-party binaries.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Homebrew Cask Logic Definition
  # -----------------------------------------------------------------------
  module = {
    lib,
    config,
    ...
  }: let
    # We extract 'homeDirectory' from our unified 'user-meta' profile
    # to ensure the application path is dynamically calculated
    # for the "rusel" user.
    inherit (config.user-meta) homeDirectory;
  in {
    homebrew.caskArgs = {
      # ### User-Level Application Directory
      # By default, Homebrew installs Casks into the system-wide
      # '/Applications' folder. We force 'nix-darwin' to use the
      # user-specific '~/Applications' directory instead.
      #
      # Benefits:
      # - Isolation: Keeps user-installed apps separate from system tools.
      # - Permissions: Avoids permission conflicts and reduces the need
      #   for root access during standard app installations.
      appdir = lib.mkForce "${homeDirectory}/Applications";

      # ### Checksum Verification
      # We disable mandatory SHA checksum verification for Cask downloads.
      #
      # Why this is helpful:
      # Some macOS applications (like Google Chrome or Telegram) use
      # "living" URLs where the binary is updated frequently without
      # changing the download link. Disabling strict SHA requirements
      # prevents 'nixh' (nh) switch failures when a Cask's remote
      # hash no longer matches the one recorded in the Homebrew formula.
      require_sha = lib.mkForce false;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # We register this customization within the 'rusel' Darwin profile.
  # This ensures that all macOS workstations belonging to "rusel"
  # share this specific application management logic.
  flake.modules.darwin.rusel.imports = [
    module
  ];
}
