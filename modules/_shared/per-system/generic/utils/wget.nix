# ----------------------------------------------------------------------------
# ## Generic Module: [Utils > wget]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.wget = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wget
    ];
  };
}
