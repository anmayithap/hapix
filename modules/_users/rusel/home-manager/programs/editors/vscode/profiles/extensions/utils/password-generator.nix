{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.motivesoft.vscode-password-generator
      ];

      userSettings = lib.mkBefore {
        "vscode-password-generator.excludeSimilarCharacters" = true;
        "vscode-password-generator.includeNumbers" = true;
        "vscode-password-generator.includeSymbols" = true;
        "vscode-password-generator.length" = 24;
      };
    };
  };
}
