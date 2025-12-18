_: {
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) username;
    inherit (config.user-meta) homeDirectory;
  in {
    home.username = lib.mkDefault username;
    home.homeDirectory = lib.mkDefault homeDirectory;
    home.stateVersion = lib.mkDefault "25.11";
  };
}
