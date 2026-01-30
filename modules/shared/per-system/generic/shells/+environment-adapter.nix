# ----------------------------------------------------------------------------
# ## ZSH Module (Adapter): Injects zsh into the environment
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
