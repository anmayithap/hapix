# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fastfetch] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fastfetch = _: {
    programs.fish = {
      # functions = lib.mkIf predicate {
      #   fish_greeting.body = lib.mkForce ''
      #     "fastfetch"
      #   '';
      # };
      shellAbbrs = {
        ff = "fastfetch";
      };
    };
  };
}
