{
  lib,
  config,
  ...
}: let
  gitEnabled = config.programs.git.enable;

  zshEnabled = config.custom.zsh.enable;
in {
  programs.lazygit = lib.mkIf gitEnabled {
    enable = lib.mkDefault true;
  };

  custom.zsh.configFiles.".zshrc".fragments."lazygit-aliases" =
    lib.mkIf
    (zshEnabled && gitEnabled) {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => LAZYGIT ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias lzg='${lib.getExe config.programs.lazygit.package}'
      '';
      order = 908;
    };
}
