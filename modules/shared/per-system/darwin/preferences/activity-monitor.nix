# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Activity Monitor
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.ActivityMonitor.plist` or `defaults read com.apple.ActivityMonitor`
{
  flake.modules.darwin.activity-monitor = {lib, ...}: {
    # ## Activity Monitor Application
    system.defaults.ActivityMonitor = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.ActivityMonitor.IconType
      # 5 - CPU Usage
      IconType = lib.mkDefault 5;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.ActivityMonitor.OpenMainWindow
      # true - Open the main window when the app is activated
      OpenMainWindow = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.ActivityMonitor.ShowCategory
      # 101 - Show all processes, Hierarchically
      ShowCategory = lib.mkDefault 101;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.ActivityMonitor.SortColumn
      SortColumn = lib.mkDefault "CPUUsage";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.ActivityMonitor.SortDirection
      # 0 - Descending
      SortDirection = lib.mkDefault 0;
    };
  };
}
