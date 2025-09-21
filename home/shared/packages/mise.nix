{lib, ...}: {
  custom.mise = {
    enable = lib.mkDefault true;

    settings = {
      experimental = true;
    };
  };
}
