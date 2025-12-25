{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: {
    programs.ssh = {
      enable = lib.mkForce true;
      enableDefaultConfig = lib.mkForce false;

      extraOptionOverrides = {
        Ciphers = "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr";
        KexAlgorithms = "curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256";
        MACs = "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com";
        HostKeyAlgorithms = "ssh-ed25519,rsa-sha2-512,rsa-sha2-256";
      };

      matchBlocks = {
        "*" = {
          controlMaster = "auto";
          controlPath = "${config.home.homeDirectory}/.ssh/sockets/%r@%h-%p";
          controlPersist = "10m";
          hashKnownHosts = true;
          serverAliveCountMax = 3;
          serverAliveInterval = 60;
          compression = true;
          addKeysToAgent = "yes";
        };
        "github.com" = {
          hostname = "ssh.github.com";
          port = 443;
          user = "git";
          identityFile = "${config.home.homeDirectory}/.ssh/maple";
          identitiesOnly = true;
        };
        "vpn" = {
          hostname = "5.129.233.150";
          user = "rusel";
        };
      };
    };
  };
}
