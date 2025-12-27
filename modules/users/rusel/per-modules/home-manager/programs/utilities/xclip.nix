# =========================================================================
# == USER PROFILE: rusel (Clipboard Utilities - xclip)
# This module integrates 'xclip' into the user environment. It provides
# a command-line interface to the X11 clipboard, enabling seamless
# data transfer between shell pipes and the system-wide copy/paste buffer
# on Linux-based systems.
# =========================================================================
{
  flake.modules.homeManager.rusel = {pkgs, ...}: {
    # -----------------------------------------------------------------------
    # ## User Packages
    # -----------------------------------------------------------------------
    home.packages = with pkgs; [
      # ### xclip
      # A standard utility for interacting with X11 selections.
      #
      # Key workflows:
      # - CLI-to-GUI: 'cat file.txt | xclip -sel clip' (Copy to clipboard).
      # - GUI-to-CLI: 'xclip -o -sel clip > local.txt' (Paste from clipboard).
      # - Editor Integration: Often required by Vim/Neovim to access the
      #   system clipboard in Linux/WSL2 (with X-server) environments.
      xclip
    ];
  };
}
