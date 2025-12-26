# =========================================================================
# == SHARED NIXOS PROFILE: Base System (nixos)
# This module acts as the primary orchestrator for all NixOS (Linux)
# configurations. It aggregates external flake modules with internal
# system defaults, security policies, and application suites.
#
# This ensures that your Linux environment remains structurally consistent
# with your macOS setup, using identical program categories and settings.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## NixOS Module Composition
  # -----------------------------------------------------------------------
  # We register this profile under 'nixos.nixos' in our registry.
  # This provides a single, high-level entry point for all Linux hosts.
  flake.modules.nixos.nixos.imports = [
    # -----------------------------------------------------------------------
    # ### External Framework Integrations
    # -----------------------------------------------------------------------
    # Essential frameworks that extend the NixOS core capabilities.
    inputs.home-manager.nixosModules.home-manager # Declarative user environments
    inputs.nix-index-database.nixosModules.nix-index # Fast command-not-found lookup
    inputs.agenix.nixosModules.default # System-level secret management

    # -----------------------------------------------------------------------
    # ### Core System Infrastructure
    # -----------------------------------------------------------------------
    # Foundational settings for the NixOS operating system.
    inputs.self.modules.nixos.documentation # Manuals, info pages, and help
    inputs.self.modules.nixos.environment # Global environment variables & PATH
    inputs.self.modules.nixos.fonts # System-wide typography & font-config
    inputs.self.modules.nixos.nix-settings # Nix daemon, GC, and optimization
    inputs.self.modules.nixos.time # Timezone, locale, and NTP config

    # -----------------------------------------------------------------------
    # ### Data & Security Services
    # -----------------------------------------------------------------------
    # Services providing metadata discovery and secure state.
    inputs.self.modules.nixos.nix-index-database # Weekly-updated index data
    inputs.self.modules.nixos.secrets # Integration with agenix/age

    # -----------------------------------------------------------------------
    # ### Application & Tooling Suites
    # -----------------------------------------------------------------------
    # Categorized programs providing a standardized CLI and dev environment.
    inputs.self.modules.nixos.system-programs # Essential NixOS/Linux utilities
    inputs.self.modules.nixos.editor-programs # Standard text editors (Neovim/etc)
    inputs.self.modules.nixos.language-programs # Runtimes (Go, Rust, Python, etc.)
    inputs.self.modules.nixos.network-programs # Network discovery and remote access
    inputs.self.modules.nixos.shell-programs # Shells (Zsh/Bash) and modern CLI tools

    # -----------------------------------------------------------------------
    # ### Global Policies
    # -----------------------------------------------------------------------
    # Licensing and shared cross-platform logic.
    inputs.self.modules.nixos.unfree # Proprietary software toggle
  ];
}
