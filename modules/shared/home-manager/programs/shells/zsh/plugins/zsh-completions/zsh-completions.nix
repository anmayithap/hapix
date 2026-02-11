# ----------------------------------------------------------------------------
# ## Home Manager Module: zsh-completions Preset
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zsh = {lib, ...}: {
    programs.zsh = {
      enableCompletion = lib.mkDefault true;
    };
  };
}
