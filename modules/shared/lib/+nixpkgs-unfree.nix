{
  flake = {
    lib = {
      nixpkgs-unfree = names: {lib, ...}: {
        nixpkgs.config.allowUnfreePredicate = package: lib.elem (lib.getName package) names;
      };
    };
  };
}
