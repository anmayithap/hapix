_: {
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh.initExtra = lib.mkBefore ''
      # === Zstyle (Alias Finder) ===

      zstyle ':omz:plugins:alias-finder' autoload yes
      zstyle ':omz:plugins:alias-finder' longer yes
      zstyle ':omz:plugins:alias-finder' exact yes
      zstyle ':omz:plugins:alias-finder' cheaper yes
    '';
  };
}
