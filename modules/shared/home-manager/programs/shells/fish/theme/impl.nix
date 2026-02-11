# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > Theme]
# Implementation
# ----------------------------------------------------------------------------
# To get the color palette for a theme, use:
#
# 1. fish_config theme show             # To get the current theme
# 2. fish_config theme choose ${theme}  # To select a theme
# 3. fish_config theme dump             # To get the color palette
{
  flake.modules.homeManager.fish = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.fish;

    themes = {
      "none" = ''
        set fish_color_autosuggestion brblack --theme=none
        set fish_color_cancel --theme=none
        set fish_color_command --theme=none
        set fish_color_comment --theme=none
        set fish_color_cwd normal --theme=none
        set fish_color_cwd_root normal --theme=none
        set fish_color_end --theme=none
        set fish_color_error --theme=none
        set fish_color_escape --theme=none
        set fish_color_history_current --theme=none
        set fish_color_host normal --theme=none
        set fish_color_host_remote yellow --theme=none
        set fish_color_normal normal --theme=none
        set fish_color_operator --theme=none
        set fish_color_param --theme=none
        set fish_color_quote --theme=none
        set fish_color_redirection --theme=none
        set fish_color_search_match -r --theme=none
        set fish_color_selection -r --theme=none
        set fish_color_status normal --theme=none
        set fish_color_user normal --theme=none
        set fish_color_valid_path --theme=none
        set fish_pager_color_completion normal --theme=none
        set fish_pager_color_description brblack --theme=none
        set fish_pager_color_prefix --underline --theme=none
        set fish_pager_color_progress brblack --theme=none
        set fish_pager_color_selected_background -r --theme=none
        set fish_pager_color_selected_completion
        set fish_pager_color_selected_description
        set fish_pager_color_selected_prefix
      '';

      "ayu" = ''
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
      '';
    };
  in {
    config = lib.mkIf cfg.enable {
      programs.fish.shellInit = lib.mkBefore themes.${cfg.theme};
    };
  };
}
