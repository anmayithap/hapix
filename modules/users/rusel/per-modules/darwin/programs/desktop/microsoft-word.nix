let
  microsoft-word = {
    name = "microsoft-word";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      microsoft-word
    ];
  };
}
