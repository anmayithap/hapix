# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fastfetch] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fastfetch = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.enable && config.programs.fastfetch.enable;
  in {
    programs.fish = {
      functions = lib.mkIf predicate {
        fish_greeting.body = lib.mkForce ''
          "fastfetch"
        '';
      };
      shellAbbrs = {
        ff = "fastfetch";
      };
    };
  };
}
