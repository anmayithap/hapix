{lib, ...}: {
  custom.direnv = {
    enable = lib.mkDefault true;
    nix-direnv.enable = lib.mkDefault true;
    silent = lib.mkDefault true;
  };
}
