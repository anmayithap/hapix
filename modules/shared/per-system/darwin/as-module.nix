# ----------------------------------------------------------------------------
# ## Darwin Module: [As Module]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.darwin.darwin.imports = [
    # ## Home Manager
    inputs.home-manager.darwinModules.home-manager
    # ## Nix Index Database
    inputs.nix-index-database.darwinModules.nix-index
    # ## Nix Homebrew
    inputs.nix-homebrew.darwinModules.nix-homebrew
    # ## Agenix
    inputs.agenix.darwinModules.default
  ];
}
