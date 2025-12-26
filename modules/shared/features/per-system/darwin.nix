# =========================================================================
# == SHARED DARWIN PROFILE: Base System (darwin)
# This module acts as the primary orchestrator for all macOS configurations.
# It aggregates external flake modules with internal system defaults,
# security policies, and application suites. By importing this profile,
# a host gains the full "Hapix" standard environment.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Darwin Module Composition
  # -----------------------------------------------------------------------
  # We register this profile under 'darwin.darwin' in our registry.
  # This provides a single entry point for machine-level configurations.
  flake.modules.darwin.darwin.imports = [
    # -----------------------------------------------------------------------
    # ### External Framework Integrations
    # -----------------------------------------------------------------------
    # These modules extend nix-darwin with third-party capabilities.
    inputs.home-manager.darwinModules.home-manager # Declarative dotfiles
    inputs.nix-index-database.darwinModules.nix-index # Fast file-to-package lookup
    inputs.nix-homebrew.darwinModules.nix-homebrew # Declarative Homebrew taps
    inputs.agenix.darwinModules.default # Encrypted secrets management

    # -----------------------------------------------------------------------
    # ### Core System Infrastructure
    # -----------------------------------------------------------------------
    # Foundational settings for the Darwin operating system.
    inputs.self.modules.darwin.documentation # Manuals and help files
    inputs.self.modules.darwin.environment # Global shell environment & variables
    inputs.self.modules.darwin.fonts # System-wide typography & NerdFonts
    inputs.self.modules.darwin.nix-settings # Optimization & Nix daemon config
    inputs.self.modules.darwin.time # Timezone and NTP synchronization

    # -----------------------------------------------------------------------
    # ### Data & Security Services
    # -----------------------------------------------------------------------
    # High-level services for system integrity and data discovery.
    inputs.self.modules.darwin.nix-index-database # Weekly-updated index database
    inputs.self.modules.darwin.secrets # Integration with agenix/age

    # -----------------------------------------------------------------------
    # ### Application & Tooling Suites
    # -----------------------------------------------------------------------
    # Categorized programs grouped by their functional purpose.
    inputs.self.modules.darwin.system-programs # Core nix-darwin CLI tools
    inputs.self.modules.darwin.editor-programs # Neovim, Emacs, or other IDEs
    inputs.self.modules.darwin.language-programs # Compilers, Runtimes (Rust, Go, etc.)
    inputs.self.modules.darwin.network-programs # SSH, VPN, and discovery tools
    inputs.self.modules.darwin.shell-programs # Zsh/Fish and CLI utilities (e.g., eza)

    # -----------------------------------------------------------------------
    # ### Hardware & UI Interaction (The Library)
    # -----------------------------------------------------------------------
    # The granular internal modules we documented previously.
    inputs.self.modules.darwin.networking # Firewall & Interface settings
    inputs.self.modules.darwin.power # Sleep and energy management
    inputs.self.modules.darwin.system # System Defaults (Dock, Finder, etc.)
    inputs.self.modules.darwin.homebrew # Homebrew service orchestration
    inputs.self.modules.darwin.security # PAM (TouchID) and sudo settings
    inputs.self.modules.darwin.nix-homebrew # Pinned taps and immutability logic

    # -----------------------------------------------------------------------
    # ### Global Policies
    # -----------------------------------------------------------------------
    # Licensing and shared cross-platform settings.
    inputs.self.modules.darwin.unfree # Proprietary software toggle
  ];
}
