{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.shellAliases = with pkgs; {
      jq = "${lib.getExe yq}";
    };
  };
}
