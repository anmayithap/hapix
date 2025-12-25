{
  flake.modules.darwin.rusel = {lib, ...}: {
    services.dnscrypt-proxy = {
      enable = lib.mkDefault true;

      settings = {
        server_names = [
          "geohide"
          "cloudflare"
        ];

        lb_strategy = "first";

        static = {
          geohide = {
            stamp = "sdns://AgcAAAAAAAAAAAASZG5zLmdlb2hpZGUucnU6NDQ0Ci9kbnMtcXVlcnk";
          };
        };

        listen_addresses = [
          "127.0.0.1:53"
        ];

        log_level = 0;

        cache = true;
        cache_size = 512;
        force_tcp = true;

        ipv6_servers = false;
      };
    };
  };
}
