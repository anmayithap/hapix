# ----------------------------------------------------------------------------
# ## Time Preferences Module: Configures the time preferences
# ----------------------------------------------------------------------------
{
  flake.modules.generic.time = {lib, ...}: {
    time.timeZone = lib.mkDefault "Europe/Moscow";
  };
}
