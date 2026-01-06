# =========================================================================
# == USER PROFILE: rusel (IDE - Visual Studio Code)
# This module configures VS Code for the "rusel" profile. It integrates
# with the shared selective unfree policy to allow the proprietary binary
# and ensures the editor is available across all managed platforms.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Licensing Policy
    # -----------------------------------------------------------------------
    # Explicitly whitelist VS Code in the selective unfree software policy.
    # This is required because the standard VS Code binary is proprietary.
    unfree = with pkgs.stable; [vscode];

    # -----------------------------------------------------------------------
    # ## Program Configuration
    # -----------------------------------------------------------------------
    programs.vscode = {
      # ### Core Activation
      # Force-enable VS Code as the primary GUI text editor.
      enable = lib.mkForce true;

      # ### Package Selection
      # Use the standard 'vscode' package from nixpkgs.
      # This provides the official Microsoft build with full extension support.
      package = pkgs.stable.vscode;
    };
  };
}
