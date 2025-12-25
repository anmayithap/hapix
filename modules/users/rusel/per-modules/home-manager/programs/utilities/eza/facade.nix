{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs = {
      fzf = {
        changeDirWidgetOptions = with pkgs; [
          "--preview '${lib.getExe eza} --tree | head -200'"
        ];
      };
    };
  };
}
