# =========================================================================
# == USER PROFILE: rusel (Directory Navigation - zoxide)
# This module configures 'zoxide', a smarter replacement for the 'cd'
# command. It tracks filesystem usage patterns to enable "frecency" based
# jumping, significantly accelerating navigation across deeply nested
# project directories.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zoxide = {
      # ### Core Activation
      # Force-enable zoxide globally for the user profile.
      # Using 'lib.mkForce' ensures that this navigation engine is the
      # standard across all managed workstations.
      enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Behavioral Options
      # -----------------------------------------------------------------------
      # We use 'lib.mkBefore' to establish the primary command alias.
      options = lib.mkBefore [
        # #### Command Override (--cmd cd)
        # By default, zoxide uses the 'z' command. By passing '--cmd cd',
        # we transparently replace the standard shell 'cd' with zoxide.
        #
        # This allows you to use 'cd' normally for direct paths while
        # gaining the ability to jump to frequent directories using
        # partial matches (e.g., 'cd hapix' to jump to your flake root).
        "--cmd cd"
      ];

      # Note: Home Manager automatically handles the shell integration
      # for Zsh/Bash, ensuring the 'cd' hook is correctly initialized.
    };
  };
}
