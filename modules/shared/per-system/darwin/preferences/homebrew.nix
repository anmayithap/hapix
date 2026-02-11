# ----------------------------------------------------------------------------
# ## Darwin Module: [Preferences > Homebrew]
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.homebrew = {
    lib,
    config,
    ...
  }: {
    homebrew = {
      enable = lib.mkDefault true;

      global = {
        autoUpdate = lib.mkDefault false;
      };

      onActivation = {
        autoUpdate = lib.mkDefault true;
        cleanup = lib.mkDefault "zap";
        extraFlags = lib.mkBefore [
          "--verbose"
        ];
      };

      taps = lib.optionalAttrs config.nix-homebrew.enable builtins.attrNames config.nix-homebrew.taps;
    };
  };
}
