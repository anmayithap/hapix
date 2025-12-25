{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh.plugins = lib.mkAfter [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    programs.zsh.initContent = lib.mkOrder 1000 ''
      zstyle ':fzf-tab:*' fzf-min-height 15
      zstyle ':fzf-tab:complete:(cd|z|ls|lsd|eza):*' fzf-preview \
        'eza -1 $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview \
        'eza -1 $realpath'
      zstyle ':fzf-tab:complete:*:*' fzf-preview \
        'if [ -d $realpath ]; then
          eza -1 $realpath
        else
          bat --style=numbers --color=always --line-range :500 $realpath
        fi'
      zstyle ':fzf-tab:*' use-fzf-default-opts yes
      zstyle ':fzf-tab:*' switch-group '<' '>'
    '';
  };
}
