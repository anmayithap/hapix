# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim]
# Declaration
# -----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    config,
    ...
  }: let
    wlib = inputs.wrapper.lib;
    cfg = config.wrappers.neovim;
  in {
    config.wrappers.neovim = {
      specMods = {
        options = {
          prePkgs = lib.mkOption {
            type = lib.types.listOf wlib.types.stringable;
            default = [];
            defaultText = ''[]'';
            description = ''
              Packages to put to prefix to the PATH.
            '';
            example = lib.literalExpression ''
              specs.general = {
                prePkgs = [
                  pkgs.neovim-qt
                ];
              };
            '';
          };

          postPkgs = lib.mkOption {
            type = lib.types.listOf wlib.types.stringable;
            default = [];
            defaultText = ''[]'';
            description = ''
              Packages to put to suffix to the PATH.
            '';
            example = lib.literalExpression ''
              specs.general = {
                postPkgs = [
                  pkgs.neovim-qt
                ];
              };
            '';
          };

          meta = lib.mkOption {
            type = wlib.types.attrsRecursive;
            default = {};
            defaultText = ''{}'';
            description = ''
              An optional `meta` spec field to add to the main info plugin instead of the spec specific one.
            '';
            example = lib.literalExpression ''
              specs.general = {
                meta = {
                  homepage = "https://github.com/neovim/neovim";
                };
              };
            '';
          };
        };
      };
    };

    options.wrappers.neovim = {
      settings = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "havix";
          defaultText = ''"havix"'';
          description = ''
            Name that participates in the configuration NVIM_APPNAME, directories, etc.
          '';
        };

        wrapMode = lib.mkOption {
          type = lib.types.enum ["development" "production"];
          default = "production";
          defaultText = ''"production"'';
          description = ''
            The wrap mode.
            This option allows you to change the behavior of the configuration:

            1. Clean installation of neovim
            2. Dirty installation of neovim
          '';
          example = lib.literalExpression ''
            settings.wrapMode = "development";
          '';
        };

        wrapped_directory = lib.mkOption {
          type = lib.types.either wlib.types.stringable lib.types.luaInline;
          default = ./havix;
          defaultText = ''./havix'';
          description = ''
            The configuration directory wrapped for neovim.
            Does not allow changing the configuration at runtime.
          '';
        };

        unwrapped_directory = lib.mkOption {
          type = lib.types.either wlib.types.stringable lib.types.luaInline;
          default = lib.mkLuaInline "vim.fn.stdpath('config')";
          defaultText = ''vim.fn.stdpath('config')'';
          description = ''
            The configuration directory unwrapped for neovim.
            Allows changing the configuration at runtime.
          '';
        };

        specs = lib.mkOption {
          type = with lib.types; attrsOf bool;
          default = builtins.mapAttrs (_: v: v.enable) cfg.specs;
          description = ''The specs for neovim. Provides activation info per spec.'';

          readOnly = true;
        };
      };
    };
  };
}
