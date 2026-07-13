#: ----------------------------------------------------------------------------
#: ## [DEFAULTS -> user] default settings for users aspects
#: ----------------------------------------------------------------------------
{
  flake-file.inputs = {
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
    };
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
