# =========================================================================
# == USER PROFILE: rusel (Terminal Emulator - Alacritty)
# This module configures Alacritty, a high-performance, GPU-accelerated
# terminal emulator. It prioritizes a polished visual experience with
# the Ayu Dark theme, high-density typography, and macOS-optimized
# keyboard ergonomics.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.alacritty = {
      # ### Core Activation
      # Enable Alacritty as a primary terminal. We use 'lib.mkDefault' to
      # allow specialized hosts to opt-out if they prefer other emulators.
      enable = lib.mkDefault true;

      # ### Aesthetics
      # Standardize on the Ayu Dark theme for a consistent color palette
      # across terminal applications and code editors.
      theme = "ayu_dark";

      # -----------------------------------------------------------------------
      # ## Alacritty Settings (alacritty.toml)
      # -----------------------------------------------------------------------
      settings = {
        # #### System Integration
        general = {
          # Enables the IPC socket, allowing external scripts or CLI tools
          # to control Alacritty windows dynamically.
          ipc_socket = true;
        };

        # #### Window Management
        window = {
          # Defines the initial terminal size in characters.
          dimensions = {
            lines = 52;
            columns = 120;
          };

          # Visuals: Full opacity with background blur enabled (supported
          # natively on macOS).
          opacity = 1;
          blur = true;

          # Start Alacritty in 'Maximized' mode to utilize screen space
          # immediately upon launch.
          startup_mode = "Maximized";

          # Allows the terminal title to reflect the current process or directory.
          dynamic_title = true;

          # Keyboard Ergonomics: Map the Left Option key to 'Alt'.
          # This is critical for shell navigation (e.g., Alt+f/b) and CLI
          # shortcuts, while keeping the Right Option key available for
          # special character input.
          option_as_alt = "OnlyLeft";
        };

        # #### Typography
        font = {
          # Integrated with our shared 'fonts' module. Uses the patched
          # variant of JetBrains Mono for rich icon support.
          normal = {
            family = "JetBrainsMono NF";
            style = "Regular";
          };

          # Size 13 provides an optimal balance between information density
          # and legibility on high-resolution Retina displays.
          size = 13;
        };

        # #### Interaction
        selection = {
          # Automatically sync selected text with the system clipboard.
          save_to_clipboard = true;
        };
      };
    };
  };
}
