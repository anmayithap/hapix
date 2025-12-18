{lib, ...}: {
  config.flake = {
    meta = {
      uri = lib.mkDefault "github:anmayithap/hapix";
    };
  };
}
