{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    fd = lib.getExe config.programs.fd.package;

    fdFileCommand = "${fd} --type f";
    fdDirCommand = "${fd} --type d";
  in {
    programs.fzf = {
      defaultCommand = lib.mkForce fdFileCommand;
      fileWidgetCommand = lib.mkForce fdFileCommand;
      changeDirWidgetCommand = lib.mkForce fdDirCommand;
    };

    programs.zsh.shellAliases = {
      find = "${fd}";
      fdf = "${fdFileCommand}";
      fdd = "${fdDirCommand}";
    };
  };
}
