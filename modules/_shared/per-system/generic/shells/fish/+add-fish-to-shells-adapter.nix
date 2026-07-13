# ----------------------------------------------------------------------------
# ## Generic Module: [Shells > Fish] environment integration
# ----------------------------------------------------------------------------
{
  flake.modules.generic.fish = {
    lib,
    config,
    ...
  }: {
    environment.shells = lib.mkIf config.programs.fish.enable (
      lib.mkBefore [
        config.programs.fish.package
      ]
    );
  };
}
