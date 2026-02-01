# ----------------------------------------------------------------------------
# ## Home Manager: Programs section configuration
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.programs = {
    imports = [
      inputs.self.modules.homeManager.nix-index-database
    ];
  };
}
