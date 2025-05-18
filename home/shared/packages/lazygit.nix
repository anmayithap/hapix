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

  custom.zsh.configFiles.".zshrc".fragments."lazygit-aliases" = lib.mkIf zshEnabled {
    text = ''
      alias lzg='lazygit'
    '';
    order = 909;
  };
}
