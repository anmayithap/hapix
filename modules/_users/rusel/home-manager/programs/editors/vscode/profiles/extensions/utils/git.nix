{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    unfree = lib.mkAfter [
      pkgs.nix-vscode-extensions.open-vsx.mhutchie.git-graph
    ];

    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.mhutchie.git-graph
        pkgs.nix-vscode-extensions.open-vsx.waderyan.gitblame
        pkgs.nix-vscode-extensions.open-vsx.anhkhoakz.gi-better
        pkgs.nix-vscode-extensions.open-vsx.lang2hong.githd
        pkgs.nix-vscode-extensions.open-vsx.donjayamanne.githistory
        pkgs.nix-vscode-extensions.vscode-marketplace.lamartire.git-indicators
        pkgs.nix-vscode-extensions.vscode-marketplace.qezhu.gitlink
      ];

      userSettings = lib.mkBefore {
        "gitblame.ignoreWhitespaces" = true;
        "gitHistory.includeRemoteBranches" = true;
        "gitHistory.sideBySide" = true;
      };
    };
  };
}
