_: let
  module = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) homeDirectory;
  in {
    homebrew.caskArgs = {
      appdir = lib.mkForce "${homeDirectory}/Applications";
      require_sha = lib.mkForce false;
    };
  };
in {
  flake.modules.darwin.rusel.imports = [
    module
  ];
}
