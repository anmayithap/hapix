# ----------------------------------------------------------------------------
# ## Darwin Module: [Preferences > Power]
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.power = {lib, ...}: {
    power = {
      sleep = {
        # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-power.sleep.computer
        # 20 - 20 minutes
        computer = lib.mkDefault 20;
        # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-power.sleep.display
        # 30 - 30 minutes
        display = lib.mkDefault 30;
        # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-power.sleep.harddisk
        # 30 - 30 minutes
        harddisk = lib.mkDefault 30;
      };
    };
  };
}
