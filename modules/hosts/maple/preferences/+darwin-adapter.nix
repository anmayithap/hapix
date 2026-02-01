# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Forcing the nix-darwin state version
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.maple = {lib, ...}: {
    system = {
      stateVersion = lib.mkForce 6;
    };
  };
}
