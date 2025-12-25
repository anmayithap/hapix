{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh = with pkgs; {
      initContent = lib.mkOrder 1000 ''
        eval "$(${lib.getExe uv}x --generate-shell-completion zsh)"
      '';
    };
  };
}
