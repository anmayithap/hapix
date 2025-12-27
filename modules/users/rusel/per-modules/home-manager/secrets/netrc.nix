# =========================================================================
# == USER PROFILE: rusel (CLI Authentication - .netrc)
# This module manages the decryption and deployment of the '.netrc' file.
# It provides a centralized mechanism for storing credentials used by
# command-line tools like curl, git, and various language package managers
# for automated authentication without user intervention.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Registration
  # -----------------------------------------------------------------------
  # We register the authentication store within the 'rusel' profile.
  # This ensures that automated logins for remote services function
  # consistently across all workstations.
  flake.modules.homeManager.rusel = {config, ...}: let
    # Extract 'homeDirectory' to place the file in the standard location.
    inherit (config.user-meta) homeDirectory;

    # Access the private 'secrets' flake input.
    inherit (inputs) secrets;
  in {
    age = {
      # ### Secret Definitions
      secrets = {
        # #### .netrc Authentication Store
        # Standard Unix file for storing auto-login information for FTP
        # and HTTP clients.
        ".netrc" = {
          # Source: Encrypted store in the private secrets repository.
          file = "${secrets}/.netrc.age";

          # ### Permissions
          # Symbolic mode 'a+rwx,u-x,g-rwx,o-rwx' results in 600 (Read/Write).
          mode = "a+rwx,u-x,g-rwx,o-rwx";

          # ### Target Destination
          # Placed at the home root to be automatically discovered by
          # standard Unix utilities.
          path = "${homeDirectory}/.netrc";

          # Symlink: Links the target path to the decrypted secret
          # managed securely by the agenix service.
          symlink = true;
        };
      };
    };
  };
}
