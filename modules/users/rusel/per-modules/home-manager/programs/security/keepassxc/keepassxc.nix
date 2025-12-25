{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.keepassxc = {
      enable = lib.mkForce true;

      settings = {
        Browser = {
          UpdateBinaryPath = false;
        };
      };
    };
  };
}
