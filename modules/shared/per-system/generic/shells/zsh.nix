# ----------------------------------------------------------------------------
# ## ZSH Module: Configures the zsh shell
# ----------------------------------------------------------------------------
{
  flake.modules.generic.zsh = {lib, ...}: {
    programs.zsh = {
      enable = lib.mkDefault true;
    };
  };
}
