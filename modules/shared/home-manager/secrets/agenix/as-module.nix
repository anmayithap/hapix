# ----------------------------------------------------------------------------
# ## Home Manager Module: [Secrets > agenix]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.agenix = {
    lib,
    config,
    ...
  }: let
    baseDirectory =
      if config.xdg.enable
      then config.xdg.configHome
      else config.home.homeDirectory;
  in {
    age = {
      secretsDir = lib.mkDefault "${baseDirectory}/agenix/secrets";
      secretsMountPoint = lib.mkDefault "${baseDirectory}/agenix/secrets.d";
    };
  };
}
