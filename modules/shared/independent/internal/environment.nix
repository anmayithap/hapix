_: let
  environment = {
    lib,
    config,
    pkgs,
    ...
  }: {
    environment = {
      shells = lib.optionals config.programs.zsh.enable [
        pkgs.zsh
      ];

      pathsToLink = lib.optionals config.programs.zsh.enable [
        "/share/zsh"
      ];
    };
  };
in {
  flake.modules.nixos = {inherit environment;};
  flake.modules.darwin = {inherit environment;};
}
