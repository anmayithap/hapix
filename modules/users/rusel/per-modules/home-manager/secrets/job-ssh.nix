# =========================================================================
# == USER PROFILE: rusel (Corporate SSH Identity - Tatneft)
# This module manages the decryption and deployment of sensitive SSH
# assets required for corporate infrastructure access. It handles both
# the private identity key and the specialized routing configuration,
# ensuring secure and seamless connectivity to "Tatneft" resources.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Registration
  # -----------------------------------------------------------------------
  # We extend the 'rusel' Home Manager profile with infrastructure-specific
  # SSH secrets. This continues the pattern of host/domain isolation for
  # private keys.
  flake.modules.homeManager.rusel = {config, ...}: let
    # Extract 'homeDirectory' from our unified user-meta profile.
    inherit (config.user-meta) homeDirectory;

    # Access the private 'secrets' flake input.
    inherit (inputs) secrets;
  in {
    age = {
      # ### Secret Definitions
      secrets = {
        # #### Corporate SSH Private Key (tat.ssh)
        # The primary identity used for authenticating with corporate
        # servers and git repositories.
        "tat.ssh" = {
          # Source: Encrypted key in the private secrets repository.
          file = "${secrets}/tat.ssh.age";

          # Permissions: Symbolic mode for 600 (User read and write only).
          mode = "a+rwx,u-x,g-rwx,o-rwx";

          # Target Destination: Managed within the standard SSH directory.
          path = "${homeDirectory}/.ssh/tatitneft";

          # Symlink: Create a link to the decrypted secret in secure storage.
          symlink = true;
        };

        # #### Corporate SSH Config Snippet (tat.ssh.config)
        # Contains host-specific routing rules, jump-host proxies, and
        # identity mappings specific to the corporate environment.
        "tat.ssh.config" = {
          # Source: Encrypted key in the private secrets repository.
          file = "${secrets}/tat.ssh.config.age";

          # Permissions: Symbolic mode for 600 (User read and write only).
          mode = "a+rwx,u-x,g-rwx,o-rwx";

          # Target Destination: Linked to the path included in our
          # SSH adapter module (~/.ssh/ssh_tatitneft_config).
          path = "${homeDirectory}/.ssh/ssh_tatitneft_config";

          # Symlink: Create a link to the decrypted secret in secure storage.
          symlink = true;
        };
      };
    };
  };
}
