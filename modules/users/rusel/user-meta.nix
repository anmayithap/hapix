_: let
  user-meta = {
    lib,
    pkgs,
    ...
  }: {
    user-meta = {
      username = lib.mkDefault "rusel";
      name = lib.mkDefault "Ruslan";
      surname = lib.mkDefault "Torbeev";
      fullname = lib.mkDefault "Ruslan Torbeev";
      email = lib.mkDefault "ruslan.torbeev@yandex.ru";
      homeDirectory = lib.mkDefault (
        if pkgs.stdenvNoCC.isDarwin
        then "/Users/rusel"
        else "/home/rusel"
      );
    };
  };
in {
  flake.modules.darwin.rusel.imports = [
    user-meta
  ];
  flake.modules.homeManager.rusel.imports = [
    user-meta
  ];
}
