{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.aider;

  yamlFormat = pkgs.formats.yaml {};
  # zshEnabled = config.custom.zsh.enable;
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
        alias ai='aider'
      '';
      order = 901;
    };

    # custom.zsh.configFiles.".zshrc".fragments."aider-completions" = lib.mkIf zshEnabled {
    #   text = ''
    #     # aider completions (managed by custom/aider module)

    #     eval "$(aider --shell-completions zsh --config ${config.home.homeDirectory}/.aider.conf.yml)"
    #   '';
    #   order = 1004;
    # };
  };
}
