{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.zellij;

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.zellij = {
    enable = lib.mkEnableOption "zellij custom configuration module";

    package = lib.mkPackageOption pkgs "zellij" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zsh.configFiles.".zshrc".fragments."zellij-aliases" = lib.mkIf zshEnabled {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => ZELLIJ ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias zj='zellij'
      '';
      order = 905;
    };
  };
}
