{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.yzhang.markdown-all-in-one
        pkgs.nix-vscode-extensions.open-vsx.davidanson.vscode-markdownlint
      ];

      userSettings = lib.mkBefore {
        "markdown.extension.completion.enabled" = true;
        "markdown.extension.preview.autoShowPreviewToSide" = true;
        "markdown.extension.tableFormatter.normalizeIndentation" = true;
      };
    };
  };
}
