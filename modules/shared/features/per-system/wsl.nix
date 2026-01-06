# =========================================================================
# == SHARED NIXOS PROFILE: WSL Environment (wsl)
# This module acts as the primary orchestrator for NixOS systems running
# inside Windows Subsystem for Linux. It combines the specialized
# 'nixos-wsl' framework with the standard Hapix infrastructure, ensuring
# a consistent development experience across Windows and other platforms.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## WSL Module Registration
  # -----------------------------------------------------------------------
  # We register this profile under 'nixos.wsl' in our registry.
  # It mirrors the structure of our standard 'nixos.nixos' profile but
  # includes the necessary components for Windows integration.
  flake.modules.nixos.wsl = {
    imports = [
      # -----------------------------------------------------------------------
      # ### WSL Core Integration
      # -----------------------------------------------------------------------
      # This is the foundational module from the 'NixOS-WSL' project.
      # It handles the WSL-specific kernel, init system, and interop
      # with the Windows file system and environment.
      inputs.nixos-wsl.nixosModules.default

      # -----------------------------------------------------------------------
      # ### External Framework Integrations
      # -----------------------------------------------------------------------
      # Core frameworks that provide declarative user management and
      # advanced data discovery within the WSL container.
      inputs.home-manager.nixosModules.home-manager # Declarative user env
      inputs.nix-index-database.nixosModules.nix-index # Fast file-to-package lookup
      inputs.agenix.nixosModules.default # Secret management (system-wide)
      inputs.nur.modules.nixos.default # Declarative Nix package sources

      # -----------------------------------------------------------------------
      # ### Core System Infrastructure
      # -----------------------------------------------------------------------
      # Baseline settings shared across all NixOS-based systems.
      inputs.self.modules.nixos.documentation # Manuals and help systems
      inputs.self.modules.nixos.environment # Global PATH and shell env
      inputs.self.modules.nixos.fonts # Typography (crucial for WSL terminal)
      inputs.self.modules.nixos.nix-settings # Nix daemon and GC policies
      inputs.self.modules.nixos.time # Time synchronization with the host

      # -----------------------------------------------------------------------
      # ### Data & Security Services
      # -----------------------------------------------------------------------
      inputs.self.modules.nixos.nix-index-database # Optimized search database
      inputs.self.modules.nixos.secrets # Integration with age/agenix

      # -----------------------------------------------------------------------
      # ### Application & Tooling Suites
      # -----------------------------------------------------------------------
      # Categorized program suites to ensure the WSL shell feels
      # identical to your macOS or native Linux terminals.
      inputs.self.modules.nixos.system-programs # Standard Linux utilities
      inputs.self.modules.nixos.editor-programs # Neovim and other text editors
      inputs.self.modules.nixos.language-programs # Runtimes (Rust, Go, Python, etc.)
      inputs.self.modules.nixos.network-programs # SSH and network discovery
      inputs.self.modules.nixos.shell-programs # Zsh/Fish and modern CLI tools

      # -----------------------------------------------------------------------
      # ### Specialized WSL Logic
      # -----------------------------------------------------------------------
      # Internal modules containing WSL-specific tweaks (e.g., Windows
      # interop settings, path integration, or automated user creation).
      inputs.self.modules.nixos.wsl

      # -----------------------------------------------------------------------
      # ### Global Policies
      # -----------------------------------------------------------------------
      inputs.self.modules.nixos.unfree # Proprietary software policy
    ];
  };
}
