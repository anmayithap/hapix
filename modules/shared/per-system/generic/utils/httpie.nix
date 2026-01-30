# ----------------------------------------------------------------------------
# ## HTTPie Module: Configures the `httpie` package
# ----------------------------------------------------------------------------
{
  flake.modules.generic.httpie = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      httpie
    ];
  };
}
