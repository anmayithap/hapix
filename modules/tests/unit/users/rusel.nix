# -----------------------------------------------------------------------------
# ## [TESTS -> unit -> users -> rusel] Tests for rusel user
# -----------------------------------------------------------------------------
{self, ...}: {
  flake.tests.unit-users-rusel = {
    test-rusel-definition = {
      expr =
        (self ? darwinConfigurations)
        && (self.darwinConfigurations ? maple)
        && (self.darwinConfigurations.maple.config.users.users ? rusel)
        && self.darwinConfigurations.maple.config.users.users.rusel.createHome
        && !self.darwinConfigurations.maple.config.users.users.rusel.isHidden;
      expected = true;
    };
  };
}
