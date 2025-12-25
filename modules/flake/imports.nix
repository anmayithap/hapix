# =========================================================================
# == IMPORTS: Core framework and external flake modules
# This module acts as the integration hub. It pulls in external logic from
# our inputs and injects it into the flake-parts evaluation process.
# This is what enables high-level features like Home Manager integration
# and project root discovery.
# =========================================================================
{inputs, ...}: {
  imports = [
    # -----------------------------------------------------------------------
    # ## Home Manager Integration
    # -----------------------------------------------------------------------
    # This module allows defining `homeConfigurations` directly within
    # flake-parts. It streamlines how we manage user dotfiles and
    # environment settings across different systems.
    inputs.home-manager.flakeModules.home-manager

    # -----------------------------------------------------------------------
    # ## Flake-Parts Modules Support
    # -----------------------------------------------------------------------
    # This enables the `modules` attribute within flake-parts, allowing
    # the flake itself to be split into multiple, reusable files.
    # It is the foundation of our "import-tree" modular architecture.
    inputs.flake-parts.flakeModules.modules

    # -----------------------------------------------------------------------
    # ## Flake Root Discovery
    # -----------------------------------------------------------------------
    # Provides the `flake-root` attribute to all `perSystem` configurations.
    # We use this for reliable path discovery in our DevShells, formatters,
    # and system deployment scripts.
    inputs.flake-root.flakeModule
  ];
}
