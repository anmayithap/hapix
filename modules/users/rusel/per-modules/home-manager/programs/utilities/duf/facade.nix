{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.shellAliases = with pkgs; {
      df = "${lib.getExe duf}";
    };
  };
}
