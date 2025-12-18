_: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
  in {
    age.identityPaths = [
      "${homeDirectory}/.ssh/id_ed25519"
    ];
  };
}
