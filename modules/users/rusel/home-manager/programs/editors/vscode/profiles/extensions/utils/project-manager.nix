{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.alefragnani.project-manager
      ];

      userSettings = lib.mkBefore {
        "projectManager.groupList" = true;
        "projectManager.ignoreProjectsWithinProjects" = true;
        "projectManager.tags" = [
          "self"
          "job"
          "nix"
          "gfc"
          "lfc"
          "python"
          "golang"
        ];
        "projectManager.git.baseFolders" = [
          "~/dev"
          "~/learn"
          "~/.config/hapix"
          "~/.config/hapix-secret"
        ];
      };
    };
  };
}
