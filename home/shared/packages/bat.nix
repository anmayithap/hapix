{lib, ...}: {
  custom.bat = {
    enable = lib.mkDefault true;
  };

  custom.zsh.configFiles.".zshrc".fragments."bat-aliases" = {
    text = ''
      alias cat='bat'
    '';
    order = 904;
  };
}
