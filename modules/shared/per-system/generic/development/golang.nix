# ----------------------------------------------------------------------------
# ## Development: Golang
# ----------------------------------------------------------------------------
# Note: This module can be used in any other modules.${class} class,
# but it should not be used in the `homeManager` class.
{
  flake.modules.generic.golang = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      go
    ];
  };
}
