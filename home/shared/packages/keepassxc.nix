{lib, ...}: {
  programs.keepassxc = {
    enable = lib.mkDefault true;
  };
}
