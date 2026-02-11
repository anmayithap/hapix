{
  flake.modules.darwin.rusel-dns = {lib, ...}: {
    users.users._dnscrypt-proxy = {
      home = lib.mkForce "/private/var/lib/dnscrypt-proxy";
    };
  };
}
