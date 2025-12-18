{
  lib,
  config,
  ...
}: let
  zshEnabled = config.custom.zsh.enable;
in {
  programs.ripgrep = {
    enable = lib.mkDefault true;
  };

  custom.zsh.configFiles.".zshrc".fragments."ripgrep-aliases" = lib.mkIf zshEnabled {
    text = ''
      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      # => RIPGREP ALIASES
      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

      alias grep='${lib.getExe config.programs.ripgrep.package}'
    '';
    order = 910;
  };
}
