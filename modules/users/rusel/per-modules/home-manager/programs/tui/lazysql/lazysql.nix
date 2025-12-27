# =========================================================================
# == USER PROFILE: rusel (Database Management - lazysql)
# This module configures 'lazysql', a cross-platform TUI for SQL database
# management. It provides a keyboard-driven interface for interacting with
# MySQL, PostgreSQL, and SQLite, allowing for efficient schema browsing
# and query execution without leaving the terminal.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.lazysql = {
      # ### Core Activation
      # Enable lazysql globally for the user profile.
      #
      # We use 'lib.mkDefault' to ensure that this database observability
      # tool is included by default in the "rusel" interactive environment,
      # while allowing specialized hosts (e.g., restricted production
      # nodes) to disable it if necessary.
      enable = lib.mkDefault true;

      # Note: lazysql serves as a lightweight, terminal-native alternative
      # to GUI tools like DBeaver or TablePlus, fitting perfectly into
      # a keyboard-centric developer workflow.
    };
  };
}
