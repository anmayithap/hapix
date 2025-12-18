let
  microsoft-excel = {
    name = "microsoft-excel";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      microsoft-excel
    ];
  };
}
