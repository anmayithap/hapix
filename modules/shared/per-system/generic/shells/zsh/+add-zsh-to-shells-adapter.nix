# ----------------------------------------------------------------------------
# ## Generic Module: [Shells > Zsh] environment integration
# ----------------------------------------------------------------------------
{
  flake.modules.generic.zsh = {
    lib,
    pkgs,
    config,
    ...
  }: {
    environment.shells = lib.mkIf config.programs.zsh.enable (
      lib.mkBefore [
        pkgs.zsh
      ]
    );
  };
}
