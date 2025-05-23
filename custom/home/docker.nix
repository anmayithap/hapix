{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.docker;

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.docker = {
    enable = lib.mkEnableOption "docker custom configuration module";

    package = lib.mkPackageOption pkgs "docker" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zsh.configFiles.".zshrc".fragments."docker-completions" = lib.mkIf zshEnabled {
      text = ''
        # docker completions (managed by custom/docker module)

        eval "$(${lib.getExe cfg.package} completion zsh)"
      '';
      order = 1003;
    };
  };
}
