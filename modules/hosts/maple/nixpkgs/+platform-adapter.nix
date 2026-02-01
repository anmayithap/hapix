# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Forcing the host platform to aarch64-darwin
# ----------------------------------------------------------------------------
{
  flake.modules.generic.maple = {lib, ...}: {
    nixpkgs.hostPlatform = lib.mkForce "aarch64-darwin";
  };
}
