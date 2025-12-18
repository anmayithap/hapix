{lib, ...}: {
  custom.docker = {
    enable = lib.mkDefault true;
  };
}
