{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh.oh-my-zsh.plugins = lib.mkBefore [
      "sudo"
      "command-not-found"
      "alias-finder"
    ];

    programs.zsh.oh-my-zsh.extraConfig = lib.mkBefore ''
      zstyle ':omz:plugins:alias-finder' autoload yes
      zstyle ':omz:plugins:alias-finder' longer yes
      zstyle ':omz:plugins:alias-finder' exact yes
      zstyle ':omz:plugins:alias-finder' cheaper yes
    '';
  };
}
