# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all nixpkgs modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  # ## Apply generic overlays to darwin nixpkgs.
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    unfree
    nix-index-database
    dnscrypt-overlay
  ];

  # ## Apply darwin overlays to darwin nixpkgs.
  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    # ## LTS nixpkgs support
    lts-overlay
    # ## Unstable nixpkgs support
    unstable-overlay
  ];
}
