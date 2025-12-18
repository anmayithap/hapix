{
  lib,
  config,
  pkgs,
  ...
}: let
  zshEnabled = config.custom.zsh.enable;
in {
  home.packages = with pkgs; [
    lazysql
  ];

  custom.zsh.configFiles.".zshrc".fragments."lazysql-aliases" = lib.mkIf zshEnabled {
    text = ''
      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      # => LAZYSQL ALIASES
      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

      alias lzq='lazysql'
    '';
    order = 909;
  };
}
