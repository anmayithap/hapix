# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fd]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fd = {lib, ...}: {
    programs.fd = {
      enable = lib.mkDefault false;

      extraOptions = lib.mkBefore [
        "--hidden"
      ];
    };
  };
}
