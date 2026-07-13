# ----------------------------------------------------------------------------
# ## Generic Module: [Utils > HTTPie]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.httpie = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      httpie
    ];
  };
}
