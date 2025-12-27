# =========================================================================
# == USER PROFILE: rusel (System Monitor Adapter - btop)
# This module integrates 'btop' into the Zsh shell environment. It
# establishes a convenient alias that replaces the legacy 'top' command
# with a modern, high-performance, and visually rich system monitor.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Shell Integration (Zsh)
    # -----------------------------------------------------------------------
    programs.zsh = {
      # ### Tool Redirection (Aliases)
      # We map the classic 'top' command to 'btop'.
      shellAliases = {
        # #### top -> btop
        # Replaces the standard Unix process monitor with btop.
        #
        # Benefits:
        # - Visual Clarity: Provides detailed graphs for CPU, RAM, and Disk.
        # - Interactivity: Full mouse and keyboard support for process management.
        # - Reliability: By using '${lib.getExe pkgs.btop}', the alias
        #   points directly to the Nix-managed binary, ensuring it works
        #   even if btop isn't in the global $PATH.
        top = "${lib.getExe pkgs.btop}";
      };
    };
  };
}
