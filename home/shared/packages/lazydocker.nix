{
  lib,
  config,
  ...
}: let
  dockerEnabled = config.custom.docker.enable;

  zshEnabled = config.custom.zsh.enable;
in {
  programs.lazydocker = lib.mkIf dockerEnabled {
    enable = lib.mkDefault true;
  };

  custom.zsh.configFiles.".zshrc".fragments."lazydocker-aliases" = lib.mkIf zshEnabled {
    text = ''
      alias lzd='lazydocker'
    '';
    order = 908;
  };
}
