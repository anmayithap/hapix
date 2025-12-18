{lib, ...}: {
  options = {
    flake.meta = lib.mkOption {
      description = "Meta information about the flake configuration";
      type = with lib.types;
        submodule {
          options = {
            uri = lib.mkOption {
              description = "URI of the current flake";
              type = with types; str;
            };
          };
        };
    };
  };
}
