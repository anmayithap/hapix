# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Git]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.git;
  in {
    config.wrappers.neovim.specs.git = lib.mkIf cfg.enable {
      postPkgs = [
        config.programs.git.package
        config.programs.lazygit.package
      ];

      data =
        lib.optionals cfg.git.enable [
          {
            inherit (cfg.git) name pname;
            data = builtins.getAttr cfg.git.name (
              with pkgs.vimPlugins; {
                "mini.git" = mini-git;
              }
            );
            lazy = builtins.getAttr cfg.git.name {
              "mini.git" = false;
            };
          }
        ]
        ++ lib.optionals cfg.diff.enable [
          {
            inherit (cfg.diff) name pname;
            data = builtins.getAttr cfg.diff.name (
              with pkgs.vimPlugins; {
                "mini.diff" = mini-diff;
              }
            );
            lazy = builtins.getAttr cfg.diff.name {
              "mini.diff" = false;
            };
          }
        ];

      after = ["lze"];
    };
  };
}
