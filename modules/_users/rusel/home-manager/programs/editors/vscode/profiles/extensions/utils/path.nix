{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.ionutvmi.path-autocomplete
        pkgs.nix-vscode-extensions.open-vsx.christian-kohler.path-intellisense
      ];

      userSettings = lib.mkBefore {
        "path-intellisense.showHiddenFiles" = true;
      };
    };
  };
}
