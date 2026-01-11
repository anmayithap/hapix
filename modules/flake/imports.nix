# ----------------------------------------------------------------------------
# ## Imports: Importing external modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    # ## Devshell Flake Integration
    inputs.devshell.flakeModule
    # ## Treefmt Flake Integration
    inputs.treefmt-nix.flakeModule
    # ## Home Manager Flake Integration
    inputs.home-manager.flakeModules.home-manager
    # ## Flake Parts Integration (Modules)
    inputs.flake-parts.flakeModules.modules
    # ## Flake Root Integration
    inputs.flake-root.flakeModule
    # ## Flake Git Hooks Integration
    inputs.git-hooks-nix.flakeModule
  ];
}
