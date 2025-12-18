{lib, ...}: let
  module = _: {
    options = {
      user-meta = {
        username = lib.mkOption {
          type = with lib.types; str;
        };
        name = lib.mkOption {
          type = with lib.types; str;
        };
        surname = lib.mkOption {
          type = with lib.types; str;
        };
        fullname = lib.mkOption {
          type = with lib.types; str;
        };
        homeDirectory = lib.mkOption {
          type = with lib.types; str;
        };
      };
    };
  };
in {
  flake.modules.darwin.user-meta = module;
  flake.modules.nixos.user-meta = module;
  flake.modules.homeManager.user-meta = module;
}
