# ----------------------------------------------------------------------------
# ## Flake Module: Importing external modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    # ## Devshell Flake Integration
    inputs.devshell.flakeModule
    # ## Treefmt Flake Integration
    inputs.treefmt-nix.flakeModule
    # ## Flake Parts Integration (Modules)
    inputs.flake-parts.flakeModules.modules
    # ## Flake Root Integration
    inputs.flake-root.flakeModule
    # ## Flake Git Hooks Integration
    inputs.git-hooks-nix.flakeModule
  ];
}
