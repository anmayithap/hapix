# =========================================================================
# == SHARED DARWIN MODULE: System (HIToolbox / Input Methods)
# This module manages low-level keyboard interaction settings within the
# HIToolbox framework. It specifically redefines the behavior of the
# Fn/Globe key to streamline language switching on multi-lingual setups.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Keyboard Interaction Logic
  # -----------------------------------------------------------------------
  # The `hitoolbox` namespace allows for declarative management of
  # input-related behaviors that are often buried deep within the
  # macOS system preferences.
  system = {lib, ...}: {
    system.defaults.hitoolbox = {
      # ### Fn / Globe Key Usage
      # Defines the action triggered when the Fn (or Globe) key is pressed
      # on modern Apple keyboards.
      #
      # By setting this to "Change Input Source", the key becomes a
      # hardware toggle for switching between active keyboard layouts
      # (e.g., English and Russian). This is often preferred over
      # the standard Cmd+Space or Ctrl+Space shortcuts as it provides
      # a dedicated, single-key interaction.
      AppleFnUsageType = lib.mkDefault "Change Input Source";
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the HIToolbox defaults into the Darwin registry.
  # This serves as a foundational layer for ergonomic keyboard
  # interaction across all managed Darwin hosts.
  flake.modules.darwin = {inherit system;};
}
