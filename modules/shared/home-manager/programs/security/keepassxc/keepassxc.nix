# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Security > keepassxc]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.keepassxc = {lib, ...}: {
    programs.keepassxc = {
      enable = lib.mkDefault false;

      settings = {
        Browser = {
          UpdateBinaryPath = lib.mkDefault false;
        };
      };
    };
  };
}
