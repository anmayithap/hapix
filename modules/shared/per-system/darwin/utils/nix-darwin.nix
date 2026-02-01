# ----------------------------------------------------------------------------
# ## Nix Darwin Utilities Module
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.nix-darwin = {
    inputs,
    pkgs,
    ...
  }: {
    environment.systemPackages = with inputs.nix-darwin.packages.${pkgs.system}; [
      darwin-rebuild
      darwin-option
      darwin-version
      darwin-uninstaller
    ];
  };
}
