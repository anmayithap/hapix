{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.vscode-marketplace.ryu1kn.partial-diff
      ];

      userSettings = lib.mkBefore {
        "partialDiff.enableTelemetry" = false;
      };
    };
  };
}
