# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > fzf.fish]
# Implementation
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.fish.fzf-fish-plugin;

    predicate = cfg.enable && config.programs.fzf.enable;
  in {
    config = lib.mkIf predicate {
      assertions = [
        {
          assertion = config.programs.fzf.enable && config.programs.fd.enable && config.programs.bat.enable;
          message = "Programs [fzf, fd, bat] required for fzf-fish plugin.";
        }
      ];

      programs.fish.plugins = lib.mkBefore [
        {
          name = "fzf-fish";
          src = cfg.package;
        }
      ];

      programs.fzf.enableFishIntegration = lib.mkForce false;

      # ## Add file opener in $EDITOR and switcher by directory and file types
      programs.fish.shellInit = lib.mkBefore ''
        set fzf_directory_opts "--bind=ctrl-e:execute($EDITOR {} &> /dev/tty)" \
                               "--bind=ctrl-d:reload(fd --color=always --type d --type l --strip-cwd-prefix)" \
                               "--bind=ctrl-f:reload(fd --color=always --type f)"
      '';
    };
  };
}
