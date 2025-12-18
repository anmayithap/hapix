let
  deeper = {
    name = "deeper";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      deeper
    ];
  };
}
