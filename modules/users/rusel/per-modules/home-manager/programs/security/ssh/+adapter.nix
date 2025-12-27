# =========================================================================
# == USER PROFILE: rusel (SSH Infrastructure - Sockets)
# This module prepares the SSH environment for connection multiplexing.
# It ensures that the directory used for SSH control sockets exists,
# preventing errors when establishing multiple sessions over a single
# persistent connection.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Environment Registry
  # -----------------------------------------------------------------------
  # We extend the 'rusel' Home Manager profile with auxiliary SSH logic.
  flake.modules.homeManager.rusel = {
    # ### Directory Persistence
    # Nix and Git do not track empty directories. By creating a hidden
    # '.keep' file, we ensure that the '~/.ssh/sockets/' directory
    # is always present in the user's home.
    #
    # This directory is critical for the SSH 'ControlMaster' feature,
    # which stores socket files here to allow sharing a single TCP
    # connection across multiple terminal sessions or file transfers.
    home.file.".ssh/sockets/.keep".text = "";
  };
}
