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

  custom.zsh.configFiles.".zshrc".fragments."lazydocker-aliases" =
    lib.mkIf
    (zshEnabled && dockerEnabled) {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => LAZYDOCKER ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias lzd='${lib.getExe config.programs.lazydocker.package}'
      '';
      order = 907;
    };
}
