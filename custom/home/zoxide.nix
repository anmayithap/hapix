{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.zoxide;

  zshEnabled = config.custom.zsh.enable;
  zinitEnabled = config.custom.zinit.enable;
in {
  options.custom.zoxide = {
    enable = lib.mkEnableOption "zoxide custom configuration module";

    package = lib.mkPackageOption pkgs "zoxide" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zinit.plugins = lib.mkIf zinitEnabled [
      "zinit ice as:program pick:${cfg.package}/bin/zoxide"
      "zinit light ajeetdsouza/zoxide"
    ];

    custom.zsh.configFiles.".zshrc".fragments."zoxide-completions" = lib.mkIf zshEnabled {
      text = ''
        # zoxide completions (managed by custom/zoxide module)

        eval "$(${lib.getExe cfg.package} init zsh --cmd cd)"
      '';
      order = 1002;
    };
  };
}
