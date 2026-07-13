# -----------------------------------------------------------------------------
# ## [TESTS -> smoke -> health-check] Tests to check system or flake health
# -----------------------------------------------------------------------------
{
  flake.tests.smoke-health-check = {
    test-mul = {
      expr = 2 * 11;
      expected = 22;
    };
  };
}
