# =========================================================================
# == USER PROFILE: rusel (macOS System Defaults & Workspace)
# This module synchronizes the "rusel" user identity with the underlying
# macOS system settings. It defines the primary system ownership and
# organizes the graphical workspace by pinning critical stacks to the
# Dock and managing the storage location for system media.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## System Workspace Logic Definition
  # -----------------------------------------------------------------------
  module = {
    lib,
    config,
    ...
  }: let
    # We pull the username and home directory from our unified 'user-meta'
    # schema to ensure paths are absolute and identity is consistent.
    inherit (config.user-meta) username homeDirectory;
  in {
    system = {
      # ### Primary System User
      # Explicitly designates 'rusel' as the primary owner of this Darwin
      # system. This is used by nix-darwin to facilitate certain
      # administrative tasks and to ensure correct ownership of managed
      # system files.
      primaryUser = lib.mkDefault username;

      # -----------------------------------------------------------------------
      # ## UI Customization (Defaults)
      # -----------------------------------------------------------------------
      defaults = {
        # ### Dock Stacks (persistent-others)
        # We pin specific directories to the right side of the Dock (the
        # "Stacks" area). This provides instant, one-click access to
        # frequently used file locations.
        dock = {
          persistent-others = lib.mkDefault [
            # The development root: Where all repositories from our
            # HM 'dev' module are cloned.
            "${homeDirectory}/dev"

            # The standard downloads folder for quick access to web assets.
            "${homeDirectory}/Downloads"
          ];
        };

        # ### Screenshot Management
        # By default, macOS clutters the Desktop with screenshots.
        # We redirect them to a dedicated sub-folder within 'Pictures'
        # to maintain a clean, distraction-free desktop environment.
        screencapture = {
          location = lib.mkDefault "${homeDirectory}/Pictures/screenshots";
        };
      };
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # This module is integrated into the 'rusel' Darwin profile. It
  # transforms the raw OS into a tailored workstation specifically
  # optimized for the "rusel" developer workflow.
  flake.modules.darwin.rusel.imports = [
    module
  ];
}
