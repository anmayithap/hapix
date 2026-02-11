# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > preview.fish]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    pkgs,
    ...
  }: {
    options = {
      programs.fish.preview-fish-plugin = {
        enable = lib.mkEnableOption "preview.fish plugin.";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The plugin package itself.";
          default = pkgs.fetchFromGitHub {
            owner = "kidonng";
            repo = "preview.fish";
            rev = "master";
            sha256 = "sha256-dxG9Drbmy0M5c4lCzeJ4k7BnkrJwmpI4IpkeRP6CYFk=";
          };
        };
      };
    };
  };
}
