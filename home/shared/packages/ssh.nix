{
  lib,
  config,
  ...
}: let
  colimaSshConfig =
    if config.custom.colima.enable
    then [
      "${config.home.homeDirectory}/.colima/ssh_config"
    ]
    else [];
in {
  programs.ssh = {
    enable = lib.mkDefault true;
    forwardAgent = lib.mkDefault false;
    addKeysToAgent = lib.mkDefault "yes";
    compression = lib.mkDefault true;
    serverAliveInterval = lib.mkDefault 60;
    serverAliveCountMax = lib.mkDefault 3;
    hashKnownHosts = lib.mkDefault true;
    controlMaster = lib.mkDefault "auto";
    extraOptionOverrides = {
      Ciphers = "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr";
      KexAlgorithms = "curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256";
      MACs = "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com";
      HostKeyAlgorithms = "ssh-ed25519,rsa-sha2-512,rsa-sha2-256";
    };

    includes =
      colimaSshConfig;

    matchBlocks = {
      "gs-proxy01 cs-prod-app-server-1 172.21.78.10 lfc:200* lfc:stage* gis:prod gitlab.infra.tatneftm.ru lfc:dev" = {
        user = "r.torbeev";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
        identitiesOnly = true;
      };
      "github.com kulibin" = {
        identityFile = "${config.home.homeDirectory}/.ssh/maple";
        identitiesOnly = true;
      };
      "gs-proxy01" = {
        hostname = "213.159.206.102";
        port = 2201;
        forwardAgent = true;
      };
      "cs-prod-app-server-1" = {
        hostname = "192.168.60.77";
        proxyJump = "gs-proxy01";
      };
      "gis:prod" = {
        hostname = "192.168.245.5";
        proxyJump = "gs-proxy01";
      };
      "172.21.78.10 lfc:200 lfc:stage" = {
        hostname = "172.21.78.10";
        proxyJump = "cs-prod-app-server-1";
      };
      "github.com" = {
        user = "git";
        hostname = "ssh.github.com";
        port = 443;
      };
      "gitlab.infra.tatneftm.ru" = {
        hostname = "gitlab.infra.tatneftm.ru";
        port = 2224;
      };
      "lfc:dev" = {
        hostname = "192.168.100.16";
      };
      "kulibin" = {
        hostname = "kulibin-crm.ru";
        user = "ruslan";
      };
      "lfc:200:fwd lfc:stage:fwd" = {
        hostname = "172.21.78.10";
        proxyJump = "cs-prod-app-server-1";
        localForwards = [
          {
            bind.port = 6363;
            host.address = "localhost";
            host.port = 6380;
          }
          {
            bind.port = 9063;
            host.address = "localhost";
            host.port = 9000;
          }
          {
            bind.port = 8063;
            host.address = "localhost";
            host.port = 8000;
          }
        ];
      };
    };
  };
}
