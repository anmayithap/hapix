{inputs, ...}: let
  nix-homebrew = {
    lib,
    config,
    ...
  }: let
    cfg = config.homebrew;
  in {
    nix-homebrew = {
      enable = lib.optionalAttrs cfg.enable true;

      taps = {
        "homebrew/homebrew-core" = lib.mkDefault inputs.homebrew-core;
        "homebrew/homebrew-cask" = lib.mkDefault inputs.homebrew-cask;
      };

      mutableTaps = lib.mkDefault false;
    };
  };
in {
  flake.modules.darwin = {inherit nix-homebrew;};
}
