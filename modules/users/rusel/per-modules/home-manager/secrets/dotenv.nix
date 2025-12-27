# =========================================================================
# == USER PROFILE: rusel (Global Environment Secrets)
# This module manages the decryption of the global '.env' file for the
# "rusel" user. It leverages agenix to securely deploy sensitive
# environment variables, such as API keys and private tokens, directly
# to the user's home root for use in development and shell scripts.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Registration
  # -----------------------------------------------------------------------
  # We extend the 'rusel' Home Manager profile. This module ensures that
  # sensitive environment configuration is handled declaratively while
  # remaining encrypted in the repository.
  flake.modules.homeManager.rusel = {config, ...}: let
    # Extract 'homeDirectory' from our unified identity profile.
    inherit (config.user-meta) homeDirectory;

    # Access the private 'secrets' flake input containing the .age files.
    inherit (inputs) secrets;
  in {
    age = {
      # ### Secret Definitions
      secrets = {
        # #### Global .env File
        # This file typically serves as a catch-all for private variables
        # required across various projects or system services.
        ".env" = {
          # Source: Encrypted file in the private secrets repository.
          file = "${secrets}/.env.age";

          # ### Permissions
          # Symbolic representation of 444 (Read-only for all).
          # This allows development tools and shells to read the variables
          # without allowing accidental modification of the decrypted state.
          mode = "a+rwx,u-wx,g-wx,o-wx";

          # ### Target Destination
          # The file is placed directly at the root of the home directory.
          # This allows it to be easily sourced by shell configurations
          # or tools like 'direnv' via a global 'source_env' directive.
          path = "${homeDirectory}/.env";

          # Symlink: Links the target path to the decrypted secret
          # managed securely by the agenix service.
          symlink = true;
        };
      };
    };
  };
}
