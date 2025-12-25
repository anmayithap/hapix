{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zoxide = {
      enable = lib.mkForce true;
      options = lib.mkBefore [
        "--cmd cd"
      ];
    };
  };
}
