# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > Theme]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {lib, ...}: {
    options = {
      programs.fish.theme = lib.mkOption {
        type = lib.types.enum ["none" "ayu"];
        default = "none";
        description = "The theme to use for fish.";
        example = "ayu";
      };
    };
  };
}
