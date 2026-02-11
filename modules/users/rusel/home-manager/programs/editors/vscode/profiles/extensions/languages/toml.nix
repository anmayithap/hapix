{
  flake.modules.homeManager.rusel-vscode = {
    pkgs,
    lib,
    ...
  }: {
    programs.vscode.profiles.default = {
      extensions = lib.mkBefore [
        pkgs.nix-vscode-extensions.open-vsx.tombi-toml.tombi
      ];
    };
  };
}
