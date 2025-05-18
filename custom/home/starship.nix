{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.custom.starship;
in {
  options.custom.starship = {
    enable = lib.mkEnableOption "starship custom configuration module";

    package = lib.mkPackageOption pkgs "starship" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zsh.configFiles.".zshrc".fragments."starship-completions" = {
      text = ''
        # starship completions (managed by custom/starship module)

        eval "$(starship init zsh)"
      '';
      order = 1007;
    };
  };
}
