# ----------------------------------------------------------------------------
# ## Darwin Module: [Preferences > Nix Homebrew]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.darwin.homebrew = {
    lib,
    config,
    ...
  }: {
    nix-homebrew = {
      enable = lib.mkIf config.homebrew.enable true;

      taps = {
        "homebrew/homebrew-core" = lib.mkDefault inputs.homebrew-core;
        "homebrew/homebrew-cask" = lib.mkDefault inputs.homebrew-cask;
      };

      mutableTaps = lib.mkDefault false;
    };
  };
}
