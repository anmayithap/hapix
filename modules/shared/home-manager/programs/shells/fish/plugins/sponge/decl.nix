# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > sponge]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    pkgs,
    ...
  }: {
    options = {
      programs.fish.sponge-plugin = {
        enable = lib.mkEnableOption "sponge plugin.";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The plugin package itself.";
          default = pkgs.fetchFromGitHub {
            owner = "meaningful-ooo";
            repo = "sponge";
            rev = "1.1.0";
            sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
          };
        };
      };
    };
  };
}
