let
  onyx = {
    name = "onyx";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      onyx
    ];
  };
}
