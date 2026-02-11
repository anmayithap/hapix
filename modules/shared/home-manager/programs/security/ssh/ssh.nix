# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Security > ssh]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.ssh = {
    lib,
    config,
    ...
  }: {
    programs.ssh = {
      enable = lib.mkDefault false;

      enableDefaultConfig = lib.mkDefault false;

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

          serverAliveCountMax = 3;
          serverAliveInterval = 60;

          hashKnownHosts = true;
          compression = true;
          addKeysToAgent = "yes";
        };
      };
    };
  };
}
