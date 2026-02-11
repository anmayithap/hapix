# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fzf]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fzf = {lib, ...}: {
    programs.fzf = {
      enable = lib.mkDefault false;

      defaultOptions = lib.mkBefore [
        ''--style=\"full\"''
        ''--height=\"~40%\"''
        ''--border=\"bold\"''
        ''--layout=\"reverse\"''
        ''--preview-window=\"border-bold\"''
        ''--padding=\"1\"''
        ''--margin=\"1\"''
        ''--prompt=\"> \"''
        ''--marker=\">\"''
        ''--pointer=\"+\"''
        ''--separator=\"_\"''
        ''--scrollbar=\"|\"''
        ''--info=\"right\"''

        ''--bind=\"ctrl-/:toggle-preview\"''
        ''--bind=\"alt-j:preview-down\"''
        ''--bind=\"alt-k:preview-up\"''
      ];
    };
  };
}
