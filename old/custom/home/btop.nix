{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.btop;
in {
  options.custom.btop = {
    enable = lib.mkEnableOption "btop custom configuration module";

    package = lib.mkPackageOption pkgs "btop" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zsh.configFiles.".zshrc".fragments."btop-aliases" = {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => BTOP ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias top='btop'
      '';
      order = 903;
    };
  };
}
