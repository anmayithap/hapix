{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.colima;
in {
  options.custom.colima = {
    enable = lib.mkEnableOption "colima custom configuration module";

    package = lib.mkPackageOption pkgs "colima" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zsh.configFiles.".zshrc".fragments."colima-completions" = {
      text = ''
        # colima completions (managed by custom/colima module)

        eval "$(colima completion zsh)"
      '';
      order = 1006;
    };
  };
}
