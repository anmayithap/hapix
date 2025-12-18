_: let
  system = {lib, ...}: {
    system.defaults.".GlobalPreferences" = {
      "com.apple.mouse.scaling" = lib.mkDefault 5.;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
