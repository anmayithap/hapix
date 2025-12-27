let
  environment = {
    lib,
    pkgs,
    config,
    ...
  }: {
    environment = {
      shellInit = lib.mkBefore ''
        FLAKE="''$(${lib.getExe config.flake-root.package})"
        export FLAKE

        NH_FLAKE="''$(${lib.getExe config.flake-root.package})"
        export NH_FLAKE
      '';

      shellAliases = {
        nixh = "${lib.getExe pkgs.nh}";
      };
    };
  };
in {
  flake.modules = {
    darwin.environment = environment;
    nixos.environment = environment;
  };
}
