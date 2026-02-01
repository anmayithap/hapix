# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Software Update
# ----------------------------------------------------------------------------
# See: `/Library/Preferences/com.apple.SoftwareUpdate`
{
  flake.modules.darwin.software-update = {lib, ...}: {
    system.defaults.SoftwareUpdate = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates
      AutomaticallyInstallMacOSUpdates = lib.mkDefault false;
    };
  };
}
