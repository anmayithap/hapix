_: {
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs = {
      zsh = {
        shellAliases = with pkgs; {
          cat = "${lib.getExe bat}";
        };
      };
      fzf = {
        fileWidgetOptions = with pkgs; [
          "--preview '${lib.getExe bat} --style=numbers --color=always --line-range :500 {}'"
        ];
        historyWidgetOptions = with pkgs;
          lib.mkAfter [
            "--preview 'echo {} | ${lib.getExe bat} --language=sh --style=plain --color=always'"
          ];
      };
    };
  };
}
