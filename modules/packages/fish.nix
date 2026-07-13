#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> fish] the user-friendly interactive shell
#: ----------------------------------------------------------------------------
#: Source: https://github.com/fish-shell/fish-shell
#: Documentation: https://fishshell.com/docs/current/index.html
#: Changelog: https://fishshell.com/docs/current/relnotes.html
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/fish.html
{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    B = lib.mkBefore;
  in {
    packages.fish = self.wrappers.fish.wrap {
      inherit pkgs;

      configFile = {
        content = B ''
          # ------------------------------------------------------------------------------
          # ## Functions
          # ------------------------------------------------------------------------------

          # ## Add `wrapped_fish_multi_cd` function
          # Which allows you to perform dots disclosure as a cd command.
          #
          # Example:
          #   ...  -> cd ../../../
          #   .... -> cd ../../../../
          function wrapped_fish_multi_cd --description="Perform dots disclosure as a cd command"
            echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
          end

          # ## Disable fish_greeting by default
          function fish_greeting --description="Configure fish_greeting variable"; end

          # ------------------------------------------------------------------------------
          # ## Theme
          # ------------------------------------------------------------------------------

          # ## Set `ayu` color scheme
          set fish_color_autosuggestion 4D5566 --theme=ayu
          set fish_color_cancel -r --theme=ayu
          set fish_color_command 39BAE6 --theme=ayu
          set fish_color_comment 626A73 --theme=ayu
          set fish_color_cwd 59C2FF --theme=ayu
          set fish_color_cwd_root red --theme=ayu
          set fish_color_end F29668 --theme=ayu
          set fish_color_error FF3333 --theme=ayu
          set fish_color_escape 95E6CB --theme=ayu
          set fish_color_history_current --bold --theme=ayu
          set fish_color_host normal --theme=ayu
          set fish_color_host_remote yellow --theme=ayu
          set fish_color_normal B3B1AD --theme=ayu
          set fish_color_operator E6B450 --theme=ayu
          set fish_color_param B3B1AD --theme=ayu
          set fish_color_quote C2D94C --theme=ayu
          set fish_color_redirection FFEE99 --theme=ayu
          set fish_color_search_match --background=E6B450 --bold --theme=ayu
          set fish_color_selection --background=E6B450 --bold --theme=ayu
          set fish_color_status red --theme=ayu
          set fish_color_user brgreen --theme=ayu
          set fish_color_valid_path --underline --theme=ayu
          set fish_pager_color_completion normal --theme=ayu
          set fish_pager_color_description B3A06D yellow --theme=ayu
          set fish_pager_color_prefix normal --bold --underline --theme=ayu
          set fish_pager_color_progress brwhite --background=cyan --bold --theme=ayu
          set fish_pager_color_selected_background --background=E6B450 --theme=ayu
          set fish_pager_color_selected_completion
          set fish_pager_color_selected_description
          set fish_pager_color_selected_prefix

          # ------------------------------------------------------------------------------
          # ## Plugins
          # ------------------------------------------------------------------------------

          # ## [sponge] purge history only on exit
          set sponge_purge_only_on_exit true

          # ------------------------------------------------------------------------------
          # ## Key Bindings
          # ------------------------------------------------------------------------------

          fish_vi_key_bindings insert

          # ------------------------------------------------------------------------------
          # ## Interactive
          # ------------------------------------------------------------------------------

          status is-interactive; and begin
            # ## Register `wrapped-fish-multi-cd` function as abbreviation
            # Register here because `nix-wrapper-modules` does not yet support abbreviations properly.
            abbr --add dot-dot --regex "^\\.\\.+\$" --function wrapped_fish_multi_cd
          end
        '';
      };

      plugins = with pkgs.fishPlugins; [
        sponge
      ];
    };
  };
}
