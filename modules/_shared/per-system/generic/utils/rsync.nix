# ----------------------------------------------------------------------------
# ## Generic Module: [Utils > rsync]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.rsync = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rsync
    ];
  };
}
