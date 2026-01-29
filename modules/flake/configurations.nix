# ----------------------------------------------------------------------------
# ## Configurations: Entry point for evaluating the configurations.
# ----------------------------------------------------------------------------
{inputs, ...}: let
  # See `modules/shared/lib/+conf-factory.nix` for more details.
  inherit (inputs.self.lib.confFactory.presets) mkDarwinSilicon mkLinuxX86;
in {
  flake = {
    # ------------------------------------------------------------------------
    # ## NixOS Configurations (Linux)
    # ------------------------------------------------------------------------
    nixosConfigurations = {
      birch = mkLinuxX86 "birch";
    };

    # ------------------------------------------------------------------------
    # ## Darwin Configurations (macOS)
    # ------------------------------------------------------------------------
    darwinConfigurations = {
      maple = mkDarwinSilicon "maple";
    };
  };
}
