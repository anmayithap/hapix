{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    unfree = with pkgs; [vscode];

    programs.vscode = with pkgs; {
      enable = lib.mkForce true;
      package = vscode;
    };
  };
}
