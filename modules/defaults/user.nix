#: ----------------------------------------------------------------------------
#: ## [DEFAULTS -> user] default settings for users aspects
#: ----------------------------------------------------------------------------
{
  den,
  lib,
  ...
}: let
  B = lib.mkBefore;
in {
  flake-file.inputs = {
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
    };
  };

  den.schema.user = {
    includes = [
      den.batteries.mutual-provider # ## Allows the user and host to contribute configuration to each other via `*.provides.*`
    ];

    classes = B [
      "homeManager"
    ];
  };

  den.default = {
    homeManager = {lib, ...}: let
      D = lib.mkDefault;
    in {
      home = {
        stateVersion = D "26.05";
      };
    };
  };
}
