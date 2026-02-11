{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    config,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.hverlin.mise-vscode
      ];

      userSettings = lib.mkBefore {
        "mise.binPath" = "${config.programs.mise.package}/bin/mise";
        "mise.configureExtensionsAutomatically" = false;
        "mise.checkForNewMiseVersion" = false;
        "mise.updateEnvAutomaticallyIncludePath" = true;
        "mise.updateOpenTerminalsEnvAutomatically" = true;
      };
    };
  };
}
