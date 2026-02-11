# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > zellij]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zellij = {lib, ...}: {
    programs.zellij = {
      enable = lib.mkDefault false;

      settings = {
        theme = "ayu_dark";

        show_release_notes = false;
        show_startup_tips = false;
      };
    };
  };
}
