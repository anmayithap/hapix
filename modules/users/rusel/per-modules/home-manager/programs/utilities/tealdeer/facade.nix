{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.shellAliases = with pkgs; {
      tldr = "${lib.getExe tealdeer}";
      tl = "${lib.getExe tealdeer}";
    };
  };
}
