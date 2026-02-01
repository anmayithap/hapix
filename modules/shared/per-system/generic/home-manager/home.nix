# ----------------------------------------------------------------------------
# ## Home Manager: Home section configuration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.home = {lib, ...}: {
    # ## home.StateVersion - version indicates which default settings are in effect
    # and therefore helps to avoid program configuration errors.
    # Switching to a higher status version usually requires some manual actions,
    # such as data conversion or file relocation.
    #
    # See: https://nix-community.github.io/home-manager/options.xhtml#opt-home.stateVersion
    home.stateVersion = lib.mkDefault "25.11";
  };
}
