{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.oh-my-zsh.plugins = lib.mkAfter [
      "git"
    ];

    programs.zsh.plugins = lib.mkAfter [
      {
        name = "zsh-forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
        completions = [
          "share/zsh/site-functions"
        ];
      }
    ];

    programs.zsh.initContent = lib.mkOrder 1000 ''
      zstyle ':completion:*:git-checkout:*' sort false
    '';
  };
}
