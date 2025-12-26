# =========================================================================
# == SHARED MODULE: Font Infrastructure
# This module defines the global font library for the system. It installs
# professional monospace typefaces and their patched "Nerd Font" variants
# to ensure consistent rendering of icons and symbols in the terminal,
# status bars, and IDEs across both Darwin and NixOS.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Font Logic Definition
  # -----------------------------------------------------------------------
  # We define a shared font suite. Monospaced fonts are the primary focus
  # here, as they are essential for development workflows.
  fonts = {pkgs, ...}: {
    fonts.packages = with pkgs; [
      # ### JetBrains Mono
      # A high-quality typeface designed specifically for developers.
      # It features increased x-height and specific character distinctions
      # that reduce eye strain during long coding sessions.
      jetbrains-mono

      # ### Nerd Fonts (JetBrains Mono)
      # This version includes thousands of additional glyphs and icons
      # (Material Design, Devicons, FontAwesome, etc.).
      #
      # Essential for:
      # - Terminal prompts (Starship/Oh-My-Zsh)
      # - File explorers (Neo-tree/Nvim-tree)
      # - Status bars (Sketchybar/Waybar)
      nerd-fonts.jetbrains-mono
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the font suite into both the Darwin and NixOS registries.
  # This provides "Typography Symmetry," ensuring that your code looks
  # identical whether you are working on a Mac or a Linux machine.
  flake.modules = {
    # macOS Font Registry
    darwin.fonts = fonts;

    # NixOS Font Registry
    nixos.fonts = fonts;
  };
}
