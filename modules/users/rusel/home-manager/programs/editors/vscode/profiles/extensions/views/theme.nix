{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.teabyii.ayu
      ];

      userSettings = lib.mkBefore {
        /*
        -------------
        AYU Extension
        -------------
        */
        "workbench.colorTheme" = "Ayu Dark";
        "workbench.iconTheme" = "ayu";
      };
    };
  };
}
