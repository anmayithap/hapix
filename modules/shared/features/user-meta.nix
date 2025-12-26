# =========================================================================
# == SHARED FEATURE: User Metadata Schema
# This module establishes a unified schema for user-specific information.
# It provides a central set of options to define the user's identity,
# ensuring that personal details (like full name and email) are
# accessible and consistent across Darwin, NixOS, and Home Manager.
# =========================================================================
{lib, ...}: let
  # -----------------------------------------------------------------------
  # ## Metadata Module Definition
  # -----------------------------------------------------------------------
  # We define the schema once in a local variable to ensure perfect
  # consistency across all platform registries.
  module = {
    options = {
      user-meta = {
        # ### Primary Identifiers
        # The system login name (e.g., "rusel").
        username = lib.mkOption {
          type = with lib.types; str;
          description = "The system username for the account.";
        };

        # ### Personal Information
        # Individual components of the user's name.
        name = lib.mkOption {
          type = lib.types.str;
          description = "First name.";
        };
        surname = lib.mkOption {
          type = lib.types.str;
          description = "Last name.";
        };

        # The combined full name (e.g., "Ruslan Torbeev").
        fullname = lib.mkOption {
          type = lib.types.str;
          description = "The full display name of the user.";
        };

        # ### Contact & Environment
        # The primary email used for Git commits and system notifications.
        email = lib.mkOption {
          type = lib.types.str;
          description = "The user's primary email address.";
        };

        # The absolute path to the user's home directory (e.g., "/Users/rusel").
        homeDirectory = lib.mkOption {
          type = lib.types.str;
          description = "The absolute path to the user's home folder.";
        };
      };
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # We "broadcast" this schema to all supported platform registries. This
  # allows any host—regardless of OS—to implement these options.
  flake.modules = {
    # Enabled for macOS configurations.
    darwin.user-meta = module;

    # Enabled for Linux configurations.
    nixos.user-meta = module;

    # Enabled for standalone user environment management.
    homeManager.user-meta = module;
  };
}
