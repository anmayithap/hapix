{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    unfree = [pkgs.vscode];
    programs.vscode = {
      enable = lib.mkForce true;
    };
  };
}
