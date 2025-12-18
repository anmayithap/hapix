_: let
  module = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) username;
  in {
    nix-homebrew.user = lib.mkForce username;
  };
in {
  flake.modules.darwin.rusel.imports = [
    module
  ];
}
