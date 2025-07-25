{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.posting;

  yamlFormat = pkgs.formats.yaml {};

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.posting = {
    enable = lib.mkEnableOption "posting custom configuration module";

    package = lib.mkPackageOption pkgs "posting" {};

    config = lib.mkOption {
      inherit (yamlFormat) type;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile."posting/config.yaml" = {
      source = yamlFormat.generate "posting-config" cfg.config;
    };

    custom.zsh.configFiles.".zshrc".fragments."posting-aliases" = lib.mkIf zshEnabled {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => POSTING ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias api='${lib.getExe cfg.package}'
      '';
      order = 911;
    };
  };
}
