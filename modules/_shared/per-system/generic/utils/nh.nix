# ----------------------------------------------------------------------------
# ## Generic Module: [Utils > nh]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nh = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nh
    ];
  };
}
