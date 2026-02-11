# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > TUI]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-tui = {
    imports = [
      inputs.self.modules.homeManager.rusel-lazydocker
      inputs.self.modules.homeManager.rusel-lazygit
      inputs.self.modules.homeManager.rusel-lazyjournal
      inputs.self.modules.homeManager.rusel-lazyssh
      inputs.self.modules.homeManager.rusel-lazysql
      inputs.self.modules.homeManager.rusel-posting
    ];
  };
}
