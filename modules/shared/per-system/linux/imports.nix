# ----------------------------------------------------------------------------
# ## NixOS Imports Module
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.nixos.nixos.imports = [
    # ## Home Manager
    inputs.home-manager.nixosModules.home-manager
    # ## Nix Index Database
    inputs.nix-index-database.nixosModules.nix-index
    # ## Agenix
    inputs.agenix.nixosModules.default
    # ## Nur
    inputs.nur.modules.nixos.default
  ];
}
