{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    unfree = lib.mkAfter [
      pkgs.nix-vscode-extensions.open-vsx.supermaven.supermaven
    ];

    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.supermaven.supermaven
      ];

      userSettings = lib.mkBefore {
        "supermaven.enableFixWithSupermaven" = false;
      };
    };
  };
}
