{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) homeDirectory;
  in {
    programs.ssh.includes = lib.mkAfter [
      "${homeDirectory}/.ssh/ssh_tatitneft_config"
    ];
  };
}
