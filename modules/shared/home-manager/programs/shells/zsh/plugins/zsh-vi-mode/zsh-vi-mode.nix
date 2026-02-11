# ----------------------------------------------------------------------------
# ## Home Manager Module: zsh-vi-mode Preset
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zsh = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.zsh.zsh-vi-mode;

    mkFirst = lib.mkOrder 1;
    mkLast = lib.mkOrder 1500;
  in {
    options = {
      programs.zsh.zsh-vi-mode = let
        afterInitPluginsModule = lib.types.submodule (
          {config, ...}: {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                description = ''
                  The name of the plugin.
                '';
              };
              file = lib.mkOption {
                type = lib.types.str;
                description = ''
                  The plugin script to source.
                  Required if the script name does not match {file}`name.plugin.zsh`.
                '';
              };
            };
            config.file = lib.mkDefault "${config.name}.plugin.zsh";
          }
        );
      in {
        enable = lib.mkEnableOption "zsh-vi-mode";
        package = lib.mkPackageOption pkgs "zsh-vi-mode" {};

        afterInitPlugins = lib.mkOption {
          type = lib.types.listOf afterInitPluginsModule;
          default = [];
          example = lib.literalExpression ''
            [
              {
                name = "fzf-tab;
                file = "share/fzf-tab/fzf-tab.plugin.zsh";
              }
            ]
          '';
          description = "Plugins to source in {file}`.zshrc`.";
        };
      };
    };

    config = lib.mkIf cfg.enable {
      programs.zsh = {
        plugins = mkFirst [
          {
            name = "zsh-vi-mode";
            src = cfg.package;
            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          }
        ];

        initContent = mkLast (
          let
            pluginPaths = map (plugin: "${plugin.name}/${plugin.file}") cfg.afterInitPlugins;
          in ''
            function zvm_after_init() {
              ${lib.hm.zsh.define "plugins" pluginPaths}
              for plugin in "''${plugins[@]}"; do
                [[ -f "${config.programs.zsh.dotDir}/plugins/$plugin" ]] && source "${config.programs.zsh.dotDir}/plugins/$plugin"
              done
              unset plugin plugins
            }
          ''
        );
      };
    };
  };
}
