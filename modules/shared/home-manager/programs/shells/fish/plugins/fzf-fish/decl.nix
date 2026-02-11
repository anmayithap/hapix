# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > fzf.fish]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    pkgs,
    ...
  }: {
    options = {
      programs.fish.fzf-fish-plugin = {
        enable = lib.mkEnableOption "fzf.fish plugin.";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The plugin package itself.";
          default = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "v10.3";
            sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
          };
        };
      };
    };
  };
}
