{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.plugins = lib.mkBefore [
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
        completions = [
          "share/zsh/site-functions"
        ];
      }
      {
        name = "nix-zsh-completions";
        src = pkgs.nix-zsh-completions;
        file = "share/zsh/plugins/nix/nix.plugin.zsh";
        completions = [
          "share/zsh/site-functions"
        ];
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/zsh-you-should-use/zsh-you-should-use.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
