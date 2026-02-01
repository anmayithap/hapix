# ----------------------------------------------------------------------------
# ## WSL System Preferences Module: WSL
# ----------------------------------------------------------------------------
{
  flake.modules.nixos.wsl = {lib, ...}: {
    wsl.enable = lib.mkDefault true;
  };
}
