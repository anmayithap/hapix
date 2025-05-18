{lib, ...}: {
  programs.vscode = {
    enable = lib.mkDefault true;
  };
}
