{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.shellAliases = with pkgs; {
      du = "${lib.getExe dust}";
    };
  };
}
