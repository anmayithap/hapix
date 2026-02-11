# ----------------------------------------------------------------------------
# ## Darwin Module: [Preferences > Launch]
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.launch = {lib, ...}: {
    system.defaults.LaunchServices = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.LaunchServices.LSQuarantine
      LSQuarantine = lib.mkDefault true;
    };
  };
}
