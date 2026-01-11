# ----------------------------------------------------------------------------
# ## Configurations: Entry point for evaluating the configurations.
# ----------------------------------------------------------------------------
{inputs, ...}: let
  # See `modules/shared/lib/+conf-factory.nix` for more details.
  inherit (inputs.self.lib.conf-factory) mkDarwin mkLinux;
in {
  flake = {
    # -----------------------------------------------------------------------
    # ## NixOS Configurations (Linux)
    # -----------------------------------------------------------------------
    nixosConfigurations = {
      birch = mkLinux "birch";
    };

    # -----------------------------------------------------------------------
    # ## Darwin Configurations (macOS)
    # -----------------------------------------------------------------------
    darwinConfigurations = {
      maple = mkDarwin "maple";
    };
  };
}
