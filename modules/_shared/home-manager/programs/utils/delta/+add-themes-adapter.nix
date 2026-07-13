# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > delta] themes integration
# Downloads delta themes from repository
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.delta = {
    lib,
    pkgs,
    config,
    ...
  }: let
    predicate = config.programs.delta.enable && config.programs.git.enable;
  in {
    programs.git.includes = lib.mkIf predicate (
      lib.mkAfter [
        {
          path = let
            repo = pkgs.fetchFromGitHub {
              owner = "dandavison";
              repo = "delta";
              rev = config.programs.delta.package.version;
              sha256 = "sha256-fJSKGa935kwLG8WYmT9Ncg2ozpSNMzUJx0WLo1gtVAA=";
            };
          in "${repo}/themes.gitconfig";
        }
      ]
    );
  };
}
