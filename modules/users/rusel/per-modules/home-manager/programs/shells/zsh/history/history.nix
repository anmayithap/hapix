# =========================================================================
# == USER PROFILE: rusel (Zsh History Management)
# This module configures deep history persistence and deduplication
# strategies for Zsh. It establishes a massive, high-integrity history
# database that is shared across all terminal sessions while filtering
# out redundant or destructive entries.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: {
    programs.zsh.history = {
      # -----------------------------------------------------------------------
      # ## Persistence & Sharing
      # -----------------------------------------------------------------------

      # ### History Location
      path = lib.mkForce "${config.xdg.cacheHome}/zsh/history";

      # ### Shared Context
      # Ensures multiple open terminal windows can read and write to
      # the same history database in real-time.
      append = lib.mkForce true;
      share = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Deduplication & Capacity
      # -----------------------------------------------------------------------

      # ### Scale
      # Store up to 50,000 entries. This high limit ensures months of
      # command history remain available for search and autosuggestions.
      save = lib.mkForce 50000;
      size = lib.mkForce 50000;

      # ### Aggressive Deduplication
      # We prioritize unique commands to keep the database efficient.
      # - ignoreDups: Don't record a command if it matches the previous one.
      # - ignoreAllDups: Remove older identical commands from the list.
      # - expireDuplicatesFirst: Purge duplicates first when reaching the limit.
      ignoreDups = lib.mkForce true;
      ignoreAllDups = lib.mkForce true;
      saveNoDups = lib.mkForce true;
      findNoDups = lib.mkForce true;
      expireDuplicatesFirst = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Advanced Features & Security
      # -----------------------------------------------------------------------

      # ### Extended Metadata
      # Saves the beginning timestamp and duration of each command.
      # Required for advanced history analysis tools.
      extended = lib.mkForce true;

      # ### Filtered Logging
      # Prevents specific patterns from being saved to disk.
      #
      # Using 'lib.mkBefore' to ensure these safety filters are prioritized.
      ignorePatterns = lib.mkBefore [
        "rm *" # Do not log broad destructive commands to prevent accidental recall.
      ];
    };
  };
}
