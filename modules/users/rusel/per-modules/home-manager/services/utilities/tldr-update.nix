# =========================================================================
# == USER PROFILE: rusel (Utilities - tldr)
# This module integrates 'tldr-update' into the user environment. It
# provides a convenient command to update the 'tldr' database, ensuring
# that the most up-to-date and accurate documentation is available
# to the user.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.tldr-update = {
      enable = lib.mkForce true;
    };
  };
}
