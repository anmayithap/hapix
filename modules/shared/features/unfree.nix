# =========================================================================
# == SHARED FEATURE: Unfree Software Policy
# This module acts as a global toggle for proprietary software. It maps
# a centralized 'unfree' policy from the local library to the module
# registries of all supported platforms. This ensures that Nixpkgs
# licensing rules are handled identically across Darwin, NixOS,
# and Home Manager.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Module Registry Mapping
  # -----------------------------------------------------------------------
  # We populate the internal module registries for each platform using a
  # shared helper defined in our local library (`self.lib`).
  #
  # The `nixpkgs-unfree` helper typically contains the core logic:
  # { nixpkgs.config.allowUnfree = true; }
  flake.modules = {
    # ### Darwin (macOS)
    # Accessible via `inputs.self.modules.darwin.unfree`
    darwin.unfree = inputs.self.lib.nixpkgs-unfree;

    # ### NixOS (Linux)
    # Accessible via `inputs.self.modules.nixos.unfree`
    nixos.unfree = inputs.self.lib.nixpkgs-unfree;

    # ### Home Manager
    # Accessible via `inputs.self.modules.homeManager.unfree`
    homeManager.unfree = inputs.self.lib.nixpkgs-unfree;
  };
}
