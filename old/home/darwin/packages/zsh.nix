_: {
  custom.zsh.configFiles.".zshrc".fragments."darwin-aliases" = {
    text = ''
      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      # => SYSTEM CONFIGURATION ALIASES
      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

      alias nsw='sudo darwin-rebuild switch'
    '';
    order = 910;
  };
}
