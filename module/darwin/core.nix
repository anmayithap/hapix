{lib, ...}: {
  system.stateVersion = 6;

  nix.gc = lib.mkDefault {
    automatic = true;
    interval = [
      {
        Hour = 8;
        Minute = 30;
      }
    ];
  };
}
