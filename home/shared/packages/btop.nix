{lib, ...}: {
  custom.btop = {
    enable = lib.mkDefault true;
  };

  custom.zsh.configFiles.".zshrc".fragments."btop-aliases" = {
    text = ''
      alias top='btop'
    '';
    order = 905;
  };
}
