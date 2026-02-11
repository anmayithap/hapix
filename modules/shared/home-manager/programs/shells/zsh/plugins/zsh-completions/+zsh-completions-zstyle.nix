# ----------------------------------------------------------------------------
# ## Home Manager Module: Configures zsh completions settings
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zsh = {
    lib,
    config,
    ...
  }: let
    cacheDir =
      if config.xdg.enable
      then "${config.xdg.cacheHome}/zsh"
      else "${config.home.homeDirectory}/.zsh";

    mkBeforeCompInit = lib.mkOrder 550;
  in {
    programs.zsh.initContent = mkBeforeCompInit ''
      # ## Configure zsh completers
      # 1. Extend pattern with file extensions
      # 2. Main completer
      # 3. Try to complete approximately
      zstyle ':completion:*' completer _extensions _complete _approximate

      # ## Enable completion caching
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "${cacheDir}/.zcompcache"

      # ## Enable completion menu
      zstyle ':completion:*' menu select
      zstyle ':completion:*:*:*:*:*' menu select group

      # ## Enable completion colors
      zstyle ':completion:*:*:*:*:descriptions' format '[%d]'
      zstyle ':completion:*:*:*:*:corrections' format '[%d] (errors: %e)'
      zstyle ':completion:*:default' list-colors "''${(s.:.)LS_COLORS}"

      # ## Configure groups
      zstyle ':completion:*' group-name '''

      # ## Configure completions
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' complete-options true
    '';
  };
}
