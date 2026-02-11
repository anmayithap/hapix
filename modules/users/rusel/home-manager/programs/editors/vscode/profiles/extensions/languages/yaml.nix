{
  flake.modules.homeManager.rusel-vscode = {
    pkgs,
    lib,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.redhat.vscode-yaml
      ];

      userSettings = lib.mkBefore {
        "redhat.telemetry.enabled" = false;
        "yaml.extension.recommendations" = false;
      };
    };
  };
}
