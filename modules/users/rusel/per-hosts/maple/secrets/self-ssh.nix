# =========================================================================
# == USER PROFILE: rusel (SSH Security & Identity)
# This module orchestrates the deployment of SSH private keys for the
# "rusel" user. It ensures that the "maple" workstation has its
# unique identity key available for Git operations, server access,
# and remote orchestration, managed securely through agenix.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Registration
  # -----------------------------------------------------------------------
  # We extend the 'rusel' Home Manager registry to include SSH identities.
  # This module ensures that your private keys are never stored in the
  # world-readable Nix store in a decrypted state.
  flake.modules.homeManager.rusel = {config, ...}: let
    # We extract 'homeDirectory' from our unified 'user-meta' schema
    # to ensure the key is placed in the correct location regardless
    # of the operating system (macOS vs Linux).
    inherit (config.user-meta) homeDirectory;

    # Access the private 'secrets' flake input.
    inherit (inputs) secrets;
  in {
    age = {
      # ### Secret Definitions
      # We define the mapping between the encrypted source and the
      # sensitive destination in the user's home folder.
      secrets = {
        # #### Host-Specific SSH Key (maple)
        # This key serves as the primary identity for the 'maple' host.
        # It is used for authenticating with GitHub, remote servers,
        # and potentially for decrypting other secrets via agenix.
        "maple.ssh" = {
          # The source encrypted file within the private secrets repository.
          file = "${secrets}/maple.ssh.age";

          # ### Permission Note
          # The symbolic mode 'a+rwx,u-wx,g-wx,o-wx' translates to 600 (User read and write only).
          mode = "a+rwx,u-w,g-rwx,o-rwx";

          # ### Target Destination
          # The key is placed in the standard ~/.ssh/ directory.
          # We name it 'maple' to distinguish it from other keys
          # (e.g., work, personal, or legacy keys).
          path = "${homeDirectory}/.ssh/maple";

          # Symlink: Links the target path to the decrypted secret
          # managed by the agenix service.
          symlink = true;
        };
      };
    };
  };
}
