{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.fzf = {
      enable = lib.mkForce true;
      defaultOptions = lib.mkBefore [
        "--height 40%"
        "--layout=reverse"
        "--border"

        "--info=inline"

        ''--prompt="❯"''
        ''--pointer="❯"''
        ''--marker="❯"''

        "--preview-window=right:50%:border-block"

        "--bind 'ctrl-/:toggle-preview'"
      ];
      historyWidgetOptions = lib.mkBefore [
        "--sort"
        "--exact"
        "--preview-window down:3:wrap"
      ];
    };
  };
}
