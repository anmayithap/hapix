_: {
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh = {
      initExtra = lib.mkBefore ''
        # === Zstyle (Completion) ===

        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu select
        zstyle ':completion:*:*:*:*:*' menu select group
        zstyle ':completion::complete:*' use-cache 1
      '';
    };
  };
}
