# ----------------------------------------------------------------------------
# ## Generic Module: [Preferences > Time]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.time = {lib, ...}: {
    time.timeZone = lib.mkDefault "Europe/Moscow";
  };
}
