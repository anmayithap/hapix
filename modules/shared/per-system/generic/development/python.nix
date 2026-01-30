# ----------------------------------------------------------------------------
# ## Development: Python
# ----------------------------------------------------------------------------
# Note: This module can be used in any other modules.${class} class,
# but it should not be used in the `homeManager` class.
{
  flake.modules.generic.python = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      python314
    ];
  };
}
