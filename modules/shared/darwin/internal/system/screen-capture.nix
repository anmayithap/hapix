# =========================================================================
# == SHARED DARWIN MODULE: System UI (Screen Capture / Screenshots)
# This module declaratively manages the behavior of the macOS screenshot
# utility (Cmd+Shift+3/4/5). It optimizes the output format for storage
# efficiency and ensures that filenames contain useful temporal metadata.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Screen Capture Logic Definition
  # -----------------------------------------------------------------------
  # These settings control the defaults for the 'screencapture' service,
  # affecting both the keyboard shortcuts and the Screenshot app.
  system = {lib, ...}: {
    system.defaults.screencapture = {
      # ### Filename Metadata
      # Automatically include the date and time in the screenshot filename.
      # This is essential for chronological organization and prevents
      # filename collisions when taking multiple captures in quick succession.
      include-date = lib.mkDefault true;

      # ### Save Target
      # Defines where the screenshot is sent.
      # "file" ensures the image is saved to the disk (usually the Desktop
      # unless changed elsewhere). Other options include "clipboard",
      # but "file" is preferred for a persistent record.
      target = lib.mkDefault "file";

      # ### File Format
      # Defines the image encoding.
      # While macOS defaults to "png" for lossless quality, we set this to
      # "jpg" to significantly reduce file sizes. This is ideal for
      # technical documentation and sharing images over the web where
      # extreme pixel-perfection is less critical than fast upload speeds.
      type = lib.mkDefault "jpg";
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the screen capture defaults into the Darwin registry.
  # This provides a consistent and efficient media capture workflow
  # across all managed workstations.
  flake.modules.darwin = {
    inherit system;
  };
}
