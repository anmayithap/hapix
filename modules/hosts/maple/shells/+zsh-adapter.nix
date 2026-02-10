# ----------------------------------------------------------------------------
# ## Maple Host Module: [Programs > Shells > zsh] Adapter
# ----------------------------------------------------------------------------
{
  flake.modules.generic.maple = {lib, ...}: {
    # ## Disabling zsh for this host
    programs.zsh.enable = lib.mkForce false;
  };
}
