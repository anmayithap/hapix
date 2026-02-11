# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > bat]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.bat = {lib, ...}: {
    programs.bat = {
      enable = lib.mkDefault false;

      config = {
        theme = lib.mkDefault "1337";
        style = lib.mkDefault "auto";
      };
    };
  };
}
