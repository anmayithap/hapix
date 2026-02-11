# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fd] fzf.fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fd = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.fzf-fish-plugin.enable && config.programs.fd.enable;
  in {
    programs.fish.shellInit = lib.mkIf predicate (
      lib.mkAfter ''
        set fzf_fd_opts ${lib.concatStringsSep " " config.programs.fd.extraOptions}
      ''
    );
  };
}
