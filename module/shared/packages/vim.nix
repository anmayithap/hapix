{lib, ...}: {
  programs.vim = {
    enable = lib.mkDefault true;
    enableSensible = lib.mkDefault true;
  };
}
