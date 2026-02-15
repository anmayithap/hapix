{
  flake.modules.generic.rusel-dns = {lib, ...}: {
    services.dnscrypt-proxy = {
      enable = lib.mkDefault true;

      settings = {
        /*
        ---------------
        Global settings
        ---------------
        */

        ## List of servers to use
        ##
        ## Servers that are defined in the public-resolvers.md or static resource can be specified here.
        server_names = lib.mkBefore [
          "geohide"
          "mafioznik"
          "astracat"
        ];

        ## List of local addresses and ports to listen to.
        listen_addresses = lib.mkBefore [
          "127.0.0.1:5053"
        ];

        ## Maximum number of simultaneous client connections to accept.
        max_clients = lib.mkDefault 250;

        /*
        -------------------------
        Server Selection settings
        -------------------------
        */

        ## Use servers reachable over IPv4.
        ipv4_servers = lib.mkDefault true;
        ## Use servers reachable over IPv6.
        ipv6_servers = lib.mkDefault false;
        ## Use servers implementing DNSCrypt.
        dnscrypt_servers = lib.mkDefault true;
        ## Use servers implementing DNS-over-HTTPS.
        doh_servers = lib.mkDefault true;
        ## Use servers implementing Oblivious DoH.
        odoh_servers = lib.mkDefault false;

        ## Server must support DNS security extensions (DNSSEC)
        require_dnssec = lib.mkDefault false;
        ## Server must not log user queries.
        require_nolog = lib.mkDefault true;
        ## Server must not enforce its own blacklist.
        require_nofilter = lib.mkDefault true;
        ## Server names to avoid even if they match all criteria.
        disabled_server_names = lib.mkBefore [];

        /*
        -------------------
        Connection settings
        -------------------
        */

        ## Always use TCP to connect to upstream servers.
        ## This can be useful if you need to route everything through Tor.
        ## Otherwise, leave this to `false`, as it doesn't improve security
        ## (dnscrypt-proxy will always encrypt everything even using UDP), and can
        ## only increase latency.
        force_tcp = lib.mkDefault true;
        ## Enable support for HTTP/3 (HTTP over QUIC)
        ## Note that, like DNSCrypt but unlike other HTTP versions, this uses
        ## UDP and (usually) port 443 instead of TCP.
        http3 = lib.mkDefault false;
        ## When http3 is true, always try HTTP/3 first for DoH servers.
        ## If the HTTP/3 connection fails, fallback to HTTP/2 and don't try
        ## HTTP/3 again for that server. By default, HTTP/3 is only used for
        ## servers that advertise support via the Alt-Svc header.
        ##
        ## WARNING: This setting is disabled by default because it will make
        ## connections significantly slower for servers that don't support HTTP/3.
        ## This is primarily a workaround for server operators who haven't
        ## configured their servers to send proper Alt-Svc headers. The better
        ## solution is to reach out to these operators and encourage them to
        ## fix their servers to correctly advertise HTTP/3 support.
        http3_probe = lib.mkDefault false;
        ## How long a DNS query will wait for a response, in milliseconds.
        ## A timeout below 5000 is not recommended.
        timeout = lib.mkDefault 5000;
        ## Keepalive for HTTP (HTTPS, HTTP/2, HTTP/3) queries, in seconds.
        keepalive = lib.mkDefault 30;
        ## Response for blocked queries. Options are `refused`, `hinfo` (default) or
        ## an IP response. To give an IP response, use the format `a:<IPv4>,aaaa:<IPv6>`.
        ## Using the `hinfo` option means that some responses will be lies.
        blocked_query_response = lib.mkDefault "refused";

        /*
        -------------------------------------
        Load Balancing & Performance settings
        -------------------------------------
        */

        ## Load-balancing strategy: 'wp2' (default), 'p2', 'ph', 'p<n>', 'first', or 'random'
        ## 'wp2' (default): Weighted Power of Two - selects the better performing server
        ## from two random candidates based on real-time RTT and success rates.
        ## 'p2': Randomly choose 1 of the fastest 2 servers by latency.
        ## 'ph': Randomly choose from fastest half of servers.
        ## 'p<n>': Randomly choose from fastest n servers (e.g., 'p3' for fastest 3).
        ## 'first': Always use the fastest server.
        ## 'random': Randomly choose from all servers.
        ## The response quality still depends on the server itself.
        lb_strategy = lib.mkDefault "wp2";
        ## Set to `true` to constantly try to estimate the latency of all the resolvers
        ## and adjust the load-balancing parameters accordingly, or to `false` to disable.
        ## Default is `true` that makes 'p2' `lb_strategy` work well.
        lb_estimator = lib.mkDefault true;
        ## Dynamically reduce query timeout as the number of concurrent connections
        ## approaches max_clients to prevent overload. Value must be between 0.0 and 1.0.
        ## 0.0 = no reduction, 1.0 = maximum reduction.
        ## Uses a quartic curve to keep timeout high at low load and reduce sharply near limit.
        ## For example, with timeout=5000ms, max_clients=250, and timeout_load_reduction=0.75:
        ## - At 125 connections (50% load): timeout remains ~4765ms (95.3%)
        ## - At 187 connections (75% load): timeout reduces to ~3826ms (76.5%)
        ## - At 225 connections (90% load): timeout reduces to ~2539ms (50.8%)
        ## - At 250 connections (100% load): timeout reduces to ~1250ms (25%)
        ## This helps maintain responsiveness under high load by failing fast.
        timeout_load_reduction = lib.mkDefault 0.75;
        ## Set to `true` to enable hot reloading of configuration files (like allowed-names.txt,
        ## blocked-names.txt, etc.) when they are modified. This can increase CPU and memory usage.
        ## Default is `false` (hot reloading is disabled).
        ##
        ## Note: No need because the configuration is sewn into the derivation.
        enable_hot_reload = lib.mkForce false;

        /*
        ----------------
        Logging settings
        ----------------
        */

        ## Log level (0-6, default: 2 - 0 is very verbose, 6 only contains fatal errors).
        log_level = lib.mkDefault 0;
        ## When using a log file, only keep logs from the most recent launch.
        log_file_latest = lib.mkDefault true;
        ## Maximum log files size in MB - Set to 0 for unlimited.
        log_files_max_size = lib.mkDefault 10;
        ## How long to keep backup files, in days.
        log_files_max_age = lib.mkDefault 7;
        ## Maximum log files backups to keep (or 0 to keep all backups).
        log_files_max_backups = lib.mkDefault 1;

        /*
        -------------------------------
        Certificate Management settings
        -------------------------------
        */

        ## The maximum concurrency to reload certificates from the resolvers.
        ## Default is 10.
        cert_refresh_concurrency = lib.mkDefault 10;
        ## Delay, in minutes, after which certificates are reloaded
        cert_refresh_delay = lib.mkDefault 240;

        /*
        --------------------------
        Startup & Network settings
        --------------------------
        */

        ## Bootstrap resolvers
        ##
        ## These are normal, non-encrypted DNS resolvers, that will be only used
        ## for one-shot queries when retrieving the initial resolvers list and if
        ## the system DNS configuration doesn't work.
        bootstrap_resolvers = lib.mkBefore [
          "9.9.9.11:53"
          "8.8.8.8:53"
        ];
        ## When internal DNS resolution is required, for example to retrieve
        ## the resolvers list:
        ##
        ## - queries will be sent to dnscrypt-proxy itself, if it is already
        ##   running with active servers (*)
        ## - or else, queries will be sent to fallback servers
        ## - finally, if `ignore_system_dns` is `false`, queries will be sent
        ##   to the system DNS
        ignore_system_dns = lib.mkDefault true;
        ## Maximum time (in seconds) to wait for network connectivity before
        ## initializing the proxy.
        ## Use 0 to not test for connectivity at all (not recommended),
        ## and -1 to wait as much as possible.
        netprobe_timeout = lib.mkDefault 60;
        ## Address and port to try initializing a connection to, just to check
        ## if the network is up.
        netprobe_address = lib.mkDefault "8.8.8.8:53";

        /*
        ----------------
        Filters settings
        ----------------
        */

        ## Immediately respond to IPv6-related queries with an empty response
        ## This makes things faster when there is no IPv6 connectivity, but can
        ## also cause reliability issues with some stub resolvers.
        block_ipv6 = lib.mkDefault false;
        ## Immediately respond to A and AAAA queries for host names without a domain name
        ## This also prevents "dotless domain names" from being resolved upstream.
        block_unqualified = lib.mkDefault true;
        ## Immediately respond to queries for local zones instead of leaking them to
        ## upstream resolvers (always causing errors or timeouts).
        block_undelegated = lib.mkDefault true;
        ## TTL for synthetic responses sent when a request has been blocked (due to
        ## IPv6 or blocklists).
        reject_ttl = lib.mkDefault 10;

        /*
        ------------------
        DNS Cache settings
        ------------------
        */

        ## Enable a DNS cache to reduce latency and outgoing traffic
        cache = lib.mkDefault true;
        ## Cache size
        cache_size = lib.mkDefault 4096;
        ## Minimum TTL for cached entries
        cache_min_ttl = lib.mkDefault 2400;
        ## Maximum TTL for cached entries
        cache_max_ttl = lib.mkDefault 86400;
        ## Minimum TTL for negatively cached entries
        cache_neg_min_ttl = lib.mkDefault 60;
        ## Maximum TTL for negatively cached entries
        cache_neg_max_ttl = lib.mkDefault 600;

        /*
        ----------------------
        Query Logging settings
        ----------------------
        */

        query_log = {
          file = lib.mkDefault "query.log";
          format = lib.mkDefault "tsv";
          ignored_qtypes = lib.mkBefore [
            "DNSKEY"
            "NS"
          ];
        };

        /*
        -------------------
        NX Logging settings
        -------------------
        */

        nx_log = {
          file = lib.mkDefault "nx.log";
          format = lib.mkDefault "tsv";
        };

        /*
        -----------------------------------
        Pattern-based blocking (blocklists)
        -----------------------------------
        */

        blocked_names = {
          log_file = lib.mkDefault "blocked-names.log";
          log_format = lib.mkDefault "tsv";
        };

        /*
        ----------------
        Servers settings
        ----------------
        */

        ## Remote lists of available servers
        ## Multiple sources can be used simultaneously, but every source
        ## requires a dedicated cache file.
        sources = {
          public-resolvers = {
            urls = lib.mkBefore [
              "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
              "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            ];
            minisign_key = lib.mkDefault "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            refresh_delay = lib.mkDefault 72;
          };
        };

        /*
        -----------------------
        Servers with known bugs
        -----------------------
        */

        ## Cisco servers currently cannot handle queries larger than 1472 bytes, and don't
        ## truncate responses larger than questions as expected by the DNSCrypt protocol.
        ## This prevents large responses from being received over UDP and over relays.
        ##
        ## The list below enables workarounds to make non-relayed usage more reliable
        ## until the servers are fixed.
        broken_implementations.fragments_blocked = lib.mkBefore [
          "cisco"
          "cisco-ipv6"
          "cisco-familyshield"
          "cisco-familyshield-ipv6"
          "cisco-sandbox"
          "cleanbrowsing-adult"
          "cleanbrowsing-adult-ipv6"
          "cleanbrowsing-family"
          "cleanbrowsing-family-ipv6"
          "cleanbrowsing-security"
          "cleanbrowsing-security-ipv6"
        ];

        /*
        ----------------------
        Monitoring UI settings
        ----------------------
        */

        monitoring_ui = {
          ## Enable the monitoring UI
          enabled = lib.mkDefault true;
          ## Listen address for the monitoring UI
          listen_address = lib.mkDefault "127.0.0.1:5080";
          ## Optional username and password for basic authentication
          ## To disable authentication, set username to an empty string: username = ""
          ## If both username and password are empty, no authentication is required
          username = lib.mkDefault "";
          password = lib.mkDefault "";
          ## Enable query logging in the monitoring UI
          ## This will show recent queries in the UI
          enable_query_log = lib.mkDefault true;
          ## Privacy level for the monitoring UI
          ## 0: show all details including client IPs
          ## 1: anonymize client IPs (default)
          ## 2: aggregate data only (no individual queries or domains shown)
          privacy_level = lib.mkDefault 0;
        };

        /*
        -----------------------
        Static entries settings
        -----------------------
        */
        static = {
          geohide = {
            stamp = "sdns://AgcAAAAAAAAAAAASZG5zLmdlb2hpZGUucnU6NDQ0Ci9kbnMtcXVlcnk";
          };
          astracat = {
            stamp = "sdns://AgcAAAAAAAAAAAAPZG5zLmFzdHJhY2F0LnJ1Ci9kbnMtcXVlcnk";
          };
          mafioznik = {
            stamp = "sdns://AgcAAAAAAAAAAAARZG5zLm1hZmlvem5pay54eXoKL2Rucy1xdWVyeQ";
          };
        };
      };
    };
  };
}
