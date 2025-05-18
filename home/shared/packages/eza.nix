{lib, ...}: {
  custom.eza = {
    enable = lib.mkDefault true;
  };

  custom.zsh.configFiles.".zshrc".fragments."eza-aliases" = {
    text = ''
      alias l='ls'
      alias ld='ls -d */'
      alias ll='ls -l --header --git --git-repos'
    '';
    order = 906;
  };
}
