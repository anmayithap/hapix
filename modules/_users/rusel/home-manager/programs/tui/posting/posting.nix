# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > TUI > Posting]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-posting = {lib, ...}: {
    programs.posting = {
      enable = lib.mkForce true;
    };
  };
}
