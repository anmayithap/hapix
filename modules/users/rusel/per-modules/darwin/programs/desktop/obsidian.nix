let
  obsidian = {
    name = "obsidian";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      obsidian
    ];
  };
}
