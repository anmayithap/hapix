# ----------------------------------------------------------------------------
# ## Home Manager Module: Configures zsh autosuggestions settings
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zsh = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.zsh.autosuggestion;
  in {
    programs.zsh = {
      localVariables = lib.mkIf cfg.enable {
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = 20;
      };
    };
  };
}
