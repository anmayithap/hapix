{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh = with pkgs; {
      shellAliases = {
        ff = "${lib.getExe fastfetch}";
      };
    };
  };
}
