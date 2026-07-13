{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    config,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.mkhl.direnv
      ];

      userSettings = lib.mkBefore {
        "direnv.path.executable" = "${config.programs.direnv.package}/bin/direnv";
        "direnv.restart.automatic" = true;
        "direnv.status.showChangesCount" = true;
        "direnv.watchForChanges" = true;
      };
    };
  };
}
