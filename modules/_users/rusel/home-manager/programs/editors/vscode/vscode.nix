# ----------------------------------------------------------------------------
# ## Rusel Home Manager: VSCode section configuration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-vscode = {lib, ...}: {
    programs.vscode = {
      enable = lib.mkForce true;

      standalone = lib.mkForce true;
    };
  };
}
