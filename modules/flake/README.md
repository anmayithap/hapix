# 📂 [MODULES] / FLAKE

## Infrastructure and Orchestration Core

This directory houses the foundational modules that define the behavior of the Nix Flake itself.
Unlike host-specific or user-environment configurations, these modules orchestrate the flake's evaluation,
formatting, development tools, and global metadata.

## ARCHITECTURE OVERVIEW

All modules within this directory are automatically discovered and
loaded via `inputs.import-tree` in the root `flake.nix`.
They leverage the **flake-parts** framework to cleanly
separate global logic (`flake`) from architecture-specific logic (`perSystem`).

## USAGE & MAINTENANCE

These modules are automatically evaluated and do not require manual importing into individual host configurations.
To add a new tool to your workflow: Edit devshell.nix.
To add a new architecture: Update the systems.nix file in the repository root.
To change formatting rules: Modify formatter.nix.
Changes to this directory take effect globally across the entire flake upon the next evaluation.
