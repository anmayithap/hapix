# ----------------------------------------------------------------------------
# ## Home Manager Module: zsh-autosuggestions Preset
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zsh = {lib, ...}: {
    programs.zsh = {
      autosuggestion = {
        enable = lib.mkDefault true;
        strategy = lib.mkForce ["history" "completion"];
      };
    };
  };
}
