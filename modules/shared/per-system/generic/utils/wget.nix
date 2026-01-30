# ----------------------------------------------------------------------------
# ## wget Module: Configures the `wget` package
# ----------------------------------------------------------------------------
{
  flake.modules.generic.wget = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wget
    ];
  };
}
