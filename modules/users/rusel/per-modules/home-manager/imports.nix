# =========================================================================
# == USER PROFILE: rusel (Home Manager Base)
# This module is the central orchestrator for the 'rusel' user environment.
# It aggregates all functional components—secrets, indexing, metadata,
# and program suites—into a unified profile that defines the user's
# interactive experience across all platforms.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Registry Entry
  # -----------------------------------------------------------------------
  # We register the core composition under 'homeManager.rusel'. This
  # attribute set is where we pull together all the modular pieces
  # we have documented so far.
  flake.modules.homeManager.rusel.imports = [
    # ### External Frameworks
    # Enables encrypted secret decryption within the user's home directory.
    inputs.agenix.homeManagerModules.default

    # ### System Utilities
    # Provides fast 'nix-index' lookups and the ',' (comma) runner.
    inputs.self.modules.homeManager.nix-index

    # ### Identity & Metadata
    # Injects the 'user-meta' schema and Ruslan's specific identity values.
    inputs.self.modules.homeManager.user-meta

    # ### Personal Component Suites
    # Aggregates services (like skhd/yabai) and UI programs (like sketchybar).
    inputs.self.modules.homeManager.services
    inputs.self.modules.homeManager.programs

    # ### Licensing Policies
    # Applies the selective unfree software whitelist to the user environment.
    inputs.self.modules.homeManager.unfree
  ];

  # -----------------------------------------------------------------------
  # ## Home Module Shortcut
  # -----------------------------------------------------------------------
  # To simplify access in our 'flake.nix' or host configurations, we
  # create a high-level alias. Instead of typing the full registry path,
  # we can simply reference 'inputs.self.homeModules.rusel'.
  flake.homeModules.rusel.imports = [
    inputs.self.modules.homeManager.rusel
  ];
}
