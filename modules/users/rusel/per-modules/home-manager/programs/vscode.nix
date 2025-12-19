{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.vscode = {
      enable = lib.mkForce true;
    };
  };
}
