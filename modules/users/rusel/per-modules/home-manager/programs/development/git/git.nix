# =========================================================================
# == USER PROFILE: rusel (Git Configuration)
# This module defines the global Git environment for the "rusel" user.
# It synchronizes identity metadata, enforces strict workflow policies
# (rebase, LFS, line endings), and provides a comprehensive suite of
# productivity aliases.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    # Extract identity from the shared user-meta profile.
    inherit (config.user-meta) fullname email;
  in {
    programs.git = {
      # ### Core Activation & LFS
      enable = lib.mkForce true;
      lfs.enable = lib.mkForce true;

      # ### Global Attributes & Ignores
      # Ensure consistent Line Feed (LF) endings across all platforms.
      attributes = lib.mkBefore ["* text eol=lf"];

      # Standard ignore list to prevent OS-specific and environment
      # files from being tracked.
      ignores = lib.mkBefore [
        ".DS_Store"
        ".direnv"
        ".vscode"
        ".envrc"
        ".env"
      ];

      # ### Background Maintenance
      # Enables periodic optimization of the Git repository data
      # (e.g., pre-fetching, commit-graph maintenance).
      maintenance.enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Git Settings (gitconfig)
      # -----------------------------------------------------------------------
      settings = {
        # #### Identity
        # Synchronized with the global 'user-meta' registry.
        user = {
          name = lib.mkForce fullname;
          email = lib.mkForce email;
        };

        # #### Workflow & Policy
        init.defaultBranch = lib.mkForce "master";

        # Prefer rebasing during pulls to maintain a clean, linear history.
        pull.rebase = lib.mkForce true;

        # Automatically track upstream branches and follow tags on push.
        push = {
          autoSetupRemote = lib.mkForce true;
          followTags = lib.mkForce true;
        };

        # -----------------------------------------------------------------------
        # ## Productivity Aliases
        # -----------------------------------------------------------------------
        alias = {
          # Navigation & Status
          b = "branch";
          co = "checkout";
          cob = "checkout -b";
          st = "status";

          # Advanced Logs (Pretty-printing with colors)
          ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
          ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";

          # Committing
          cm = "commit";
          cma = "commit -a";
          cmm = "commit -m";
          cmma = "commit -a -m";
          amend = "commit --amend -m";

          # Diff & Staging
          df = "diff";
          dfch = "diff --cached";
          unstage = "reset HEAD --";

          # Branch Maintenance
          merged = "branch --merged";
          unmerged = "branch --no-merged";
          non-exists = "remote prune $1 --dry-run";
          del-merged = ''! git branch --merged | egrep -v "(^\*|main|master|dev|staging|develop)" | xargs git branch -d'';
          del-non-exists = "remote prune $1";

          # Submodules
          sub-update = "submodule update --init --recursive";
          sub-foreach = "submodule foreach";
        };
      };

      # -----------------------------------------------------------------------
      # ## Security
      # -----------------------------------------------------------------------
      # Sign commits using SSH keys (integrates with your agenix SSH module).
      signing = {
        format = "ssh";
      };
    };
  };
}
