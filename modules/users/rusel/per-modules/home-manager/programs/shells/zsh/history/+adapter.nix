# =========================================================================
# == USER PROFILE: rusel (Zsh History Infrastructure)
# This module optimizes how Zsh handles command history. It ensures that
# every command is instantly persisted and properly formatted, enabling
# seamless history sharing across multiple terminal sessions and
# maintaining a clean history database.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh = {
      # -----------------------------------------------------------------------
      # ## Shell Options (History Management)
      # -----------------------------------------------------------------------
      # We use 'lib.mkBefore' to ensure these foundational history behaviors
      # are established early in the shell initialization.
      setOptions = lib.mkBefore [
        # ### Instant Persistence
        # INC_APPEND_HISTORY: Saves commands to the history file immediately
        # after they are executed, rather than waiting for the shell session
        # to close. This is crucial for multi-terminal workflows where
        # history must be shared across all open windows in real-time.
        "INC_APPEND_HISTORY"

        # ### History Cleanup
        # HIST_REDUCE_BLANKS: Removes redundant leading and trailing
        # whitespace from commands before storing them. This prevents
        # "dirty" history entries and ensures that commands are saved in
        # their canonical form.
        "HIST_REDUCE_BLANKS"
      ];
    };
  };
}
