# =========================================================================
# == SHARED MODULE: Shell Infrastructure (Zsh)
# This module defines the primary system shell. It enables Zsh globally,
# ensuring it is registered as a valid login shell across both Darwin
# and NixOS. This serves as the foundational layer for all interactive
# terminal sessions and user-specific shell configurations.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Shell Logic Definition
  # -----------------------------------------------------------------------
  # Enabling the shell at the system level is a prerequisite for using
  # it as a default login shell for users.
  shell-programs = {lib, ...}: {
    programs.zsh = {
      # ### Activation
      # Enable the Zsh shell globally.
      #
      # We use `lib.mkDefault true` to establish Zsh as our standard
      # environment while allowing specific hosts (e.g., a minimal
      # server or a specialized appliance) to revert to Bash or use
      # a different shell by overriding this setting.
      enable = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the Zsh enablement logic into both the Darwin and NixOS
  # registries. This ensures that 'zsh' is a first-class citizen
  # across the entire managed infrastructure.
  flake.modules = {
    # macOS Shell Registry
    darwin.shell-programs = shell-programs;

    # NixOS Shell Registry
    nixos.shell-programs = shell-programs;
  };
}
