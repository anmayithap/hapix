# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Notifier]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.notifier;
  in {
    config.wrappers.neovim.specs.notifier = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.notify" = mini-notify;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.notify" = false;
      };
      after = ["lze"];
    };
  };
}
