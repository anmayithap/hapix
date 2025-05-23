{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.uv;

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.uv = {
    enable = lib.mkEnableOption "uv python management tool";

    package = lib.mkPackageOption pkgs "uv" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zsh.configFiles.".zshrc".fragments."uv-completions" = lib.mkIf zshEnabled {
      text = ''
        # uv completions (managed by custom/uv module)

        eval "$(uv generate-shell-completion zsh)"
        eval "$(uvx --generate-shell-completion zsh)"
      '';
      order = 1006;
    };
  };
}
