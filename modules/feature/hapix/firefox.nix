#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> firefox] firefox preset
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

  hapix.hm-firefox = {
    homeManager = {lib, ...}: let
      D = lib.mkDefault;
    in {
      programs.firefox = {
        enable = D true;
      };
    };
  };
}
