let
  telegram = {
    name = "telegram";
  };
in {
  flake.modules.darwin.rusel = _: {
    homebrew.casks = [
      telegram
    ];
  };
}
