{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      docker
    ];

    programs.docker-cli = {
      configDir = lib.mkForce "${config.xdg.configHome}/docker";
    };
  };
}
