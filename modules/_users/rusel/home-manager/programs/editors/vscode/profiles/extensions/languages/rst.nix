{
  flake.modules.homeManager.rusel-vscode = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.swyddfa.esbonio
        pkgs.nix-vscode-extensions.open-vsx.lextudio.restructuredtext
        pkgs.nix-vscode-extensions.open-vsx.trond-snekvik.simple-rst
      ];

      userSettings = lib.mkBefore {
        "restructuredtext.pythonRecommendation.disabled" = true;
      };
    };
  };
}
