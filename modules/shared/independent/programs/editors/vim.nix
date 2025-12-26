# =========================================================================
# == SHARED MODULE: Editor Suites (Vim Baseline)
# This module defines the foundational text editing environment. It ensures
# that Vim is globally available and pre-configured with a set of "sensible"
# defaults, providing a reliable fall-back editor for terminal-based
# tasks and system-level configuration edits.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Editor Logic Definition
  # -----------------------------------------------------------------------
  # Even if high-level IDEs or Neovim are used later in the configuration,
  # providing a sane base Vim is a best practice for system integrity.
  editor-programs = {lib, ...}: {
    programs.vim = {
      # ### Activation
      # Ensures the Vim binary is installed system-wide.
      enable = lib.mkDefault true;

      # ### Sensible Defaults
      # Automatically includes the 'vim-sensible' plugin logic.
      # This provides a universally agreed-upon baseline of settings:
      # - Enables syntax highlighting and file-type detection.
      # - Sets backspace behavior and search highlighting.
      # - Configures standard indentation and line-wrap rules.
      #
      # This makes the editor immediately usable without requiring a
      # manual .vimrc for basic tasks.
      enableSensible = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the editor suite into both the Darwin and NixOS registries.
  # This guarantees that 'vim' will behave identically when running
  # 'sudoedit' or 'vi' on any machine in the flake.
  flake.modules = {
    # macOS Editor Registry
    darwin.editor-programs = editor-programs;

    # NixOS Editor Registry
    nixos.editor-programs = editor-programs;
  };
}
