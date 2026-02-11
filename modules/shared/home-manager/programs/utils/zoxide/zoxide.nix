# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > zoxide]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zoxide = {lib, ...}: {
    programs.zoxide = {
      enable = lib.mkDefault false;

      options = lib.mkBefore [
        "--cmd cd"
      ];
    };
  };
}
