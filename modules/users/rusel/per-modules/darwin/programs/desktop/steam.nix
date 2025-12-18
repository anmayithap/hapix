let
  steam = {
    name = "steam";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      steam
    ];
  };
}
