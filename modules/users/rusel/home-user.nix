# =========================================================================
# == USER PROFILE: rusel (Home Manager Integration)
# This module bridges the gap between the OS-level user and their personal
# Home Manager environment. It ensures that when 'rusel' is added to a
# system, all user-specific dotfiles, packages, and services are
# automatically orchestrated as part of the system activation.
# =========================================================================
{inputs, ...}: let
  # -----------------------------------------------------------------------
  # ## Home Manager Assignment
  # -----------------------------------------------------------------------
  # This block defines the mapping between the 'rusel' username and the
  # corresponding Home Manager configuration.
  home = {
    home-manager.users.rusel.imports = [
      # We import the 'rusel' Home Manager module from our shared
      # homeModules registry. This likely contains Zsh, Git, and
      # other personal tool configurations.
      inputs.self.homeModules.rusel
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # We register this integration for both NixOS and Darwin. This allows
  # any host to gain the "rusel" environment by simply importing
  # 'inputs.self.modules.<platform>.rusel'.
  flake.modules = {
    # ### NixOS / WSL Integration
    nixos.rusel.imports = [
      # Dependency: Ensure the core Home Manager orchestration is active.
      inputs.self.modules.nixos.home-manager

      # Implementation: Map the 'rusel' Home Manager profile.
      home
    ];

    # ### Darwin (macOS) Integration
    darwin.rusel.imports = [
      # Dependency: Ensure the core Home Manager orchestration is active.
      inputs.self.modules.darwin.home-manager

      # Implementation: Map the 'rusel' Home Manager profile.
      home
    ];
  };
}
