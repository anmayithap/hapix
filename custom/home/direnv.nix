{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.direnv;

  zshEnabled = config.custom.zsh.enable;

  tomlFormat = pkgs.formats.toml {};
in {
  options.custom.direnv = {
    enable = lib.mkEnableOption "direnv custom configuration module";

    package = lib.mkPackageOption pkgs "direnv" {};

    nix-direnv = {
      enable = lib.mkEnableOption ''
        [nix-direnv](https://github.com/nix-community/nix-direnv),
        a fast, persistent use_nix implementation for direnv
      '';

      package = lib.mkPackageOption pkgs "nix-direnv" {};
    };

    silent = lib.mkEnableOption "silent mode, that is, disabling direnv logging";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile."direnv/direnv.toml" =
      lib.mkIf cfg.silent
      {
        source = tomlFormat.generate "direnv-config" (
          lib.optionalAttrs cfg.silent {
            global = {
              log_format = "-";
              log_filter = "^$";
            };
          }
        );
      };

    xdg.configFile."direnv/lib/hm-nix-direnv.sh" = lib.mkIf cfg.nix-direnv.enable {
      source = "${cfg.nix-direnv.package}/share/nix-direnv/direnvrc";
    };

    custom.zsh.configFiles.".zshrc".fragments."direnv-hooks" = lib.mkIf zshEnabled {
      text = ''
        eval "$(${lib.getExe cfg.package} hook zsh)"
      '';
      order = 1003;
    };

    home.sessionVariables = lib.mkIf cfg.silent {DIRENV_LOG_FORMAT = "";};
  };
}
