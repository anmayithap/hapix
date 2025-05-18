{lib, ...}: {
  services.jankyborders = {
    enable = lib.mkDefault true;
  };
}
