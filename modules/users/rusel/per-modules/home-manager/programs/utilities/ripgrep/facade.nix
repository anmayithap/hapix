{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.shellAliases = with pkgs; {
      grep = "${lib.getExe ripgrep}";
    };
  };
}
