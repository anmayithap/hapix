{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.aider;

  yamlFormat = pkgs.formats.yaml {};
in {
  options.custom.aider = {
    enable = lib.mkEnableOption "aider custom configuration module";

    config = lib.mkOption {
      inherit (yamlFormat) type;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.aider-chat];

    home.file.".aider.conf.yml" = {
      source = yamlFormat.generate "aider-config" cfg.config;
    };

    custom.zsh.configFiles.".zshrc".fragments."aider-aliases" = {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => AIDER ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias ai='aider'
      '';
      order = 901;
    };
  };
}
