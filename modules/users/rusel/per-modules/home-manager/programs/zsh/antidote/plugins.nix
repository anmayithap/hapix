_: {
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh.antidote.plugins = lib.mkBefore [
      "zsh-users/zsh-completions"
      "akash329d/zsh-alias-finder"
      "zsh-users/zsh-history-substring-search"
      "jeffreytse/zsh-vi-mode"

      "getantidote/use-omz"
      ''ohmyzsh/ohmyzsh "path:lib"''
      "ohmyzsh/ohmyzsh path:plugins/sudo"
      "ohmyzsh/ohmyzsh path:plugins/command-not-found"
    ];
  };
}
