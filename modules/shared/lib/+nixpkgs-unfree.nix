{
  flake = {
    lib = {
      nixpkgs-unfree = {
        lib,
        config,
        ...
      }: {
        options.unfree = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [];
        };

        config.nixpkgs.config.allowUnfreePredicate = pkg: let
          pkgName = lib.getName pkg;
          allowedNames = map lib.getName config.unfree;
        in
          lib.elem pkgName allowedNames;
      };
    };
  };
}
