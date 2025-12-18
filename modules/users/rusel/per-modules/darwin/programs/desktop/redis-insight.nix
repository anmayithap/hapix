let
  redis-insight = {
    name = "redis-insight";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      redis-insight
    ];
  };
}
