# ----------------------------------------------------------------------------
# ## Maple Host Module: Configure nixpkgs by another defined modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  # ## Apply generic overlays to nixpkgs.
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    # ## Allow unfree predicate
    unfree
    nix-index-database
    # ## Allow dnscrypt-proxy black list generator
    dnscrypt-overlay
  ];

  # ## Apply darwin overlays to nixpkgs.
  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    # ## LTS nixpkgs support
    lts-overlay
  ];
}
