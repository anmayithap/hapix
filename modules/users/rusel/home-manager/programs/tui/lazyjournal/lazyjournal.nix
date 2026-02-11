# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > TUI > LazyJournal]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-lazyjournal = {lib, ...}: {
    programs.lazyjournal = {
      enable = lib.mkForce true;
    };
  };
}
