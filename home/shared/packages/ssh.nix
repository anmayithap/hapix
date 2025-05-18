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
    compression = lib.mkDefault true;
    forwardAgent = lib.mkDefault false;
    addKeysToAgent = lib.mkDefault "yes";
    hashKnownHosts = lib.mkDefault true;
    extraOptionOverrides = {
      Ciphers = "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr";
      KexAlgorithms = "curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256";
      MACs = "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com";
      HostKeyAlgorithms = "ssh-ed25519,rsa-sha2-512,rsa-sha2-256";
    };

    includes =
      colimaSshConfig;

    matchBlocks = {
      "github.com" = {
        user = "git";
        hostname = "ssh.github.com";
        identityFile = "${config.home.homeDirectory}/.ssh/maple";
        identitiesOnly = true;
        port = 443;
      };
      "gitlab.infra.tatneftm.ru" = {
        hostname = "gitlab.infra.tatneftm.ru";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
        port = 2224;
      };
      "gs-proxy01" = {
        user = "r.torbeev";
        hostname = "213.159.206.102";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
        port = 2201;
        forwardAgent = true;
      };
      "cs-prod-app-server-1" = {
        hostname = "192.168.60.77";
        user = "r.torbeev";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
        proxyJump = "gs-proxy01";
      };
      "gis:prod" = {
        hostname = "192.168.245.5";
        user = "r.torbeev";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
        proxyJump = "r.torbeev@213.159.206.102:2201";
      };
      "lfc:dev" = {
        hostname = "192.168.100.16";
        user = "r.torbeev";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
      };
      "lfc:stage" = {
        hostname = "172.21.78.10";
        user = "r.torbeev";
        proxyJump = "cs-prod-app-server-1";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
      };
      "lfc:200" = {
        hostname = "172.21.78.10";
        user = "r.torbeev";
        proxyJump = "cs-prod-app-server-1";
        identityFile = "${config.home.homeDirectory}/.ssh/tatitneft";
      };
      "kulibin" = {
        hostname = "kulibin-crm.ru";
        user = "ruslan";
        identityFile = "${config.home.homeDirectory}/.ssh/maple";
      };
    };
  };
}
