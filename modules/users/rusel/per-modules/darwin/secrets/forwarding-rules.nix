{inputs, ...}: {
  flake.modules.darwin.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "forwarding-rules" = {
          file = "${secrets}/forwarding-rules.age";
          mode = "0600";
          path = "${homeDirectory}/.config/dnscrypt-proxy/forwarding-rules.txt";
          symlink = true;
        };
      };
    };
  };
}
