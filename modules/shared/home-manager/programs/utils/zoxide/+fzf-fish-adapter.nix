# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > zoxide] fzf.fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zoxide = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.fzf-fish-plugin.enable && config.programs.zoxide.enable;
  in {
    programs.fish = {
      functions = lib.mkIf predicate {
        _fzf_jump_directory = {
          body = ''
            set -l current_token (commandline --current-token)

            set -l command_zoxide (
              ${lib.getExe config.programs.zoxide.package} query --list --exclude / | sort -rn | string split / -r -m 1 -f2 --allow-empty | _fzf_wrapper --query=$current_token $fzf_jump_directory_opts
            )

            if test $status -eq 0
              cd $command_zoxide
            end

            commandline --function repaint
          '';
        };

        fish_user_key_bindings = lib.mkAfter ''
          bind ctrl-g _fzf_jump_directory
          bind -M insert ctrl-g _fzf_jump_directory
        '';
      };
    };
  };
}
