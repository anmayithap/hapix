# =========================================================================
# == USER PROFILE: rusel (Directory Navigation Adapter - eza)
# This module integrates 'eza' (a modern replacement for ls) into the
# FZF directory navigation widget. It provides a rich, tree-based visual
# preview when browsing the filesystem, significantly improving the
# "Alt+C" (change directory) workflow.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs = {
      # -----------------------------------------------------------------------
      # ## Filter Integration (FZF)
      # -----------------------------------------------------------------------
      fzf = {
        # ### Change Directory Widget Preview
        # This triggers when using the 'Alt+C' shortcut to jump to
        # subdirectories.
        #
        # Logic:
        # - Uses '${lib.getExe pkgs.eza}' to ensure the preview works
        #   even if the binary is not in the user's PATH.
        # - '--tree': Renders the contents of the selected directory as
        #   a visual hierarchy.
        # - '| head -200': Limits the preview to the first 200 lines to
        #   ensure high performance and low latency on massive directories.
        changeDirWidgetOptions = [
          "--preview '${lib.getExe pkgs.eza} --tree | head -200'"
        ];
      };
    };
  };
}
