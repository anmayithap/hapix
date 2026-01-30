# ----------------------------------------------------------------------------
# ## nh Module: Configures the `nh` package
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nh = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nh
    ];
  };
}
