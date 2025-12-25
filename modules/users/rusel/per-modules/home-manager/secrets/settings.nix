_: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    baseDirectory = homeDirectory + "/.config/agenix";
  in {
    age = {
      secretsDir = baseDirectory + "/secrets";
      secretsMountPoint = baseDirectory + "/secrets.d";
    };
  };
}
