# =========================================================================
# == USER PROFILE: rusel (Secure Shell - SSH)
# This module defines the global SSH client configuration for the "rusel"
# user. It enforces a high-security cryptographic baseline, enables
# connection multiplexing for performance, and provides host-specific
# routing for GitHub and remote infrastructure.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: {
    programs.ssh = {
      # ### Core Activation
      enable = lib.mkForce true;

      # Disable the impure default SSH configuration to ensure the
      # environment is fully managed by Nix.
      enableDefaultConfig = lib.mkForce false;

      # -----------------------------------------------------------------------
      # ## Hardened Cryptography (extraOptionOverrides)
      # -----------------------------------------------------------------------
      # We restrict the client to modern, secure cryptographic primitives
      # to protect against legacy vulnerabilities and downgrade attacks.
      extraOptionOverrides = {
        Ciphers = "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr";
        KexAlgorithms = "curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256";
        MACs = "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com";
        HostKeyAlgorithms = "ssh-ed25519,rsa-sha2-512,rsa-sha2-256";
      };

      # -----------------------------------------------------------------------
      # ## Match Blocks (Host Configuration)
      # -----------------------------------------------------------------------
      matchBlocks = {
        # ### Global Defaults (*)
        "*" = {
          # #### Connection Multiplexing
          # Allows multiple SSH sessions to share a single TCP connection,
          # significantly speeding up subsequent logins and Git operations.
          controlMaster = "auto";
          controlPath = "${config.home.homeDirectory}/.ssh/sockets/%r@%h-%p";
          controlPersist = "10m";

          # #### Persistence & Keepalive
          # Prevents sessions from dropping due to inactivity or NAT timeouts.
          serverAliveCountMax = 3;
          serverAliveInterval = 60;

          # #### Security & Performance
          hashKnownHosts = true; # Privacy: Don't store plain-text hostnames in known_hosts.
          compression = true; # Efficiency: Compress data on slow connections.
          addKeysToAgent = "yes"; # UX: Automatically add decrypted keys to the SSH agent.
        };

        # ### GitHub Integration
        # Optimized for working behind restrictive firewalls or proxies.
        "github.com" = {
          hostname = "ssh.github.com";
          port = 443; # Use HTTPS port for SSH to bypass common firewall blocks.
          user = "git";

          # Reference the host-specific key managed by our agenix module.
          identityFile = "${config.home.homeDirectory}/.ssh/maple";

          # Only use the specified identity; prevents "Too many authentication
          # failures" errors by not trying every key in the agent.
          identitiesOnly = true;
        };

        # ### VPN Node
        "vpn" = {
          hostname = "5.129.233.150";
          user = "rusel";
        };
      };
    };
  };
}
