# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > eza]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.eza = {lib, ...}: {
    programs.eza = {
      enable = lib.mkDefault false;

      colors = lib.mkDefault "auto";

      icons = lib.mkDefault "auto";

      extraOptions = lib.mkBefore [
        # ## View options
        "--width=100" # columns
        # ## Filtering options
        "--group-directories-first"
        "--sort=extension"
        # ## Long view options
        "--header"
        "--smart-group"
        "--binary"
        "--git"
        "--git-repos"
        "--time-style=long-iso"
      ];
    };
  };
}
