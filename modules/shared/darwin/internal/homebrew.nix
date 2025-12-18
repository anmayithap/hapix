_: let
  homebrew = {
    lib,
    config,
    ...
  }: let
    cfg = config.nix-homebrew;
  in {
    homebrew = {
      enable = lib.mkDefault true;
      taps = lib.optionalAttrs cfg.enable builtins.attrNames cfg.taps;

      global = {
        autoUpdate = lib.mkDefault false;
      };
    };
  };
in {
  flake.modules.darwin = {inherit homebrew;};
}
