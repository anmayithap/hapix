# =========================================================================
# == SHARED MODULE: Secrets Management (Agenix Identity)
# This module establishes the identity paths used for decrypting secrets.
# It configures the 'age' encryption tool to use the system's Ed25519
# SSH host key as its private key, enabling secure, machine-specific
# secret management across both Darwin and NixOS.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Secrets Logic Definition
  # -----------------------------------------------------------------------
  # We use the system's SSH host key as the 'age' identity. This is a
  # "best practice" in the Nix ecosystem because:
  # 1. The key is unique to the physical hardware.
  # 2. The key is generated once at installation and persists.
  # 3. It allows the system to decrypt secrets during boot/activation
  #    without requiring manual user intervention or extra GPG keys.
  secrets = {
    age = {
      # ### Identity Paths
      # The list of files containing the private keys used for decryption.
      identityPaths = [
        # We target the Ed25519 host key as it is modern, secure, and
        # standard across both Linux and macOS.
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the secrets identity configuration into both the Darwin
  # and NixOS registries. This ensures that 'agenix' knows exactly where
  # to look for the host's "fingerprint" on any machine in the flake.
  flake.modules = {
    # macOS Secrets Registry
    darwin.secrets = secrets;

    # NixOS Secrets Registry
    nixos.secrets = secrets;
  };
}
