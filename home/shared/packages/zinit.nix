{lib, ...}: let
  defaultPlugins = [
    "zinit light zsh-users/zsh-syntax-highlighting"
    "zinit light zsh-users/zsh-completions"
    "zinit light zsh-users/zsh-autosuggestions"
    "zinit light akash329d/zsh-alias-finder"
    "zinit light zsh-users/zsh-history-substring-search"
    "zinit light MichaelAquilina/zsh-you-should-use"
    "zinit light wfxr/forgit"
    "zinit light jeffreytse/zsh-vi-mode"
  ];

  defaultSnippets = [
    "zinit snippet OMZP::git"
    "zinit snippet OMZP::sudo"
    "zinit snippet OMZP::command-not-found"
  ];
in {
  custom.zinit = {
    enable = lib.mkDefault true;

    plugins = defaultPlugins;
    snippets = defaultSnippets;

    postLoadCommands = ''
      zinit cdreplay -q
    '';
  };

  custom.zsh.configFiles.".zshrc".fragments."zinit-ztyles" = {
    text = ''
      zstyle ':omz:plugins:alias-finder' autoload yes
      zstyle ':omz:plugins:alias-finder' longer yes
      zstyle ':omz:plugins:alias-finder' exact yes
      zstyle ':omz:plugins:alias-finder' cheaper yes
    '';
    order = 103;
  };
}
