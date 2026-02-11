# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > TUI]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.tui = {
    imports = [
      inputs.self.modules.homeManager.lazydocker
      inputs.self.modules.homeManager.lazygit
      inputs.self.modules.homeManager.lazyjournal
      inputs.self.modules.homeManager.lazyssh
      inputs.self.modules.homeManager.lazysql
      inputs.self.modules.homeManager.posting
    ];
  };
}
