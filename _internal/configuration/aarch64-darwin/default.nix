{lib, inputs, ...}@args: let
  inherit (inputs) haumea;

  darwinFactory = import ../darwin_factory.nix;

  data = haumea.lib.load {
    src = ./src;
    inputs = args // {inherit darwinFactory;};
  };

  dataWithoutPaths = builtins.attrValues data;

  outputs = {
    darwinConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.darwinConfigurations or {}) dataWithoutPaths
    );

    packages = lib.attrsets.mergeAttrsList (map (it: it.packages or { }) dataWithoutPaths);
  };
in
outputs // {
  inherit data;
}
