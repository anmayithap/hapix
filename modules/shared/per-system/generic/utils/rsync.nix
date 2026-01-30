# ----------------------------------------------------------------------------
# ## rsync Module: Configures the `rsync` package
# ----------------------------------------------------------------------------
{
  flake.modules.generic.rsync = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rsync
    ];
  };
}
