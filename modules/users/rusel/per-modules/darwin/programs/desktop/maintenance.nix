let
  maintenance = {
    name = "maintenance";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      maintenance
    ];
  };
}
