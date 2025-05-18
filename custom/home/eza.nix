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

    custom.zsh.configFiles.".zshrc".fragments."_eza-aliases" = {
      text = ''
        alias ls='eza -A -F --group-directories-first --sort=extension --color=always "$@"'
      '';
      order = 902;
    };
  };
}
