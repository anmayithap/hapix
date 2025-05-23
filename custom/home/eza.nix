{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.eza;

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.eza = {
    enable = lib.mkEnableOption "eza custom configuration module";

    package = lib.mkPackageOption pkgs "eza" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    home.sessionVariables = {
      FPATH = lib.mkIf zshEnabled "${cfg.package}/completions/zsh:$FPATH";
    };

    custom.zsh.configFiles.".zshrc".fragments."eza-aliases" = {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => EZA ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias ls='${lib.getExe cfg.package} -A -F --group-directories-first --sort=extension --color=always "$@"'
        alias l='ls'
        alias ld='ls -d */'
        alias ll='ls -l --header --git --git-repos'
      '';
      order = 904;
    };
  };
}
