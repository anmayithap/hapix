#: ----------------------------------------------------------------------------
#: ## [HOSTS -> maple] aarch64-darwin based host
#: ----------------------------------------------------------------------------
#: HOSTNAME:   maple
#: OS:         macOS Tahoe 26.4.1 (25E253) arm64
#: KERNEL:     Darwin 25.4.0
#: CPU-CORE:   Apple M4 Pro (12) @ 4.51 GHz
#: CPU-RATE:   12PSHX / 12LGX
{
  inputs,
  maple,
  ...
}: {
  imports = [
    (inputs.den.namespace "maple" false)
  ];

  den.hosts.aarch64-darwin.maple = {lib, ...}: let
    F = lib.mkForce;
    A = lib.mkAfter;
  in {
    #: Explicitly specify the target class for building the host
    #: See: https://den.oeiuwq.com/reference/schema/#host-options
    class = F "darwin";

    users = {
      rusel = {
        classes = A [
          "homeManager"
        ];

        git = {
          name = "Ruslan Torbeev";
          email = "ruslan.torbeev@gmail.com";
        };
      };
    };

    spec = {
      cores = F 12;
    };
  };

  den.aspects.maple = {
    includes = [
      maple.host # ## Provides host options
    ];
  };

  #: Declare `maple` namespace
  maple = {};
}
