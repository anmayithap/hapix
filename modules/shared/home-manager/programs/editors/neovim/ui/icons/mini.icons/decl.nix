# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Icons > mini.icons]
# Declaration
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.neovim = {
    lib,
    pkgs,
    ...
  }: let
    inherit (inputs.nvf.lib.nvim.types) mkPluginSetupOption;

    mkCategoryOption = category:
      lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
        defaultText = "{}";
        description = ''
          Customizable category ${category} icons configuration.
        '';
      };
  in {
    options.programs.nvf.settings.vim.hapix.mini.icons = {
      enable = lib.mkEnableOption "mini.icons";

      package = lib.mkPackageOption pkgs.vimPlugins "mini-icons" {
        default = "mini-icons";
        pkgsText = "pkgs.vimPlugins";
        extraDescription = ''
          This is package of mini.icons.
          See: https://nvim-mini.org/mini.nvim/doc/mini-icons.html
        '';
      };

      vscode.enable = lib.mkEnableOption "vscode disabling wrapper";

      # ## Hooks which can be used after the setup
      hooks = {
        mock_nvim_web_devicons.enable = lib.mkEnableOption "mocking nvim-web-devicons";

        tweak_lsp_kind = {
          enable = lib.mkEnableOption "tweaking built-in LSP kind names";
          mode = lib.mkOption {
            type = lib.types.enum ["prepend" "append" "replace"];
            default = "prepend";
            defaultText = "prepend";
            description = ''
              The mode to use for the tweaking placement.

              - `prepend`: Set icon before LSP kind name
              - `append`: Set icon after LSP kind name
              - `replace`: Replace LSP kind name with icon
            '';
            example = lib.literalExpression ''
              {
                mode = "append";
              }
            '';
          };
        };
      };

      setupOpts = mkPluginSetupOption "mini.icons setup options" {
        # ## Icons style
        style = lib.mkOption {
          type = lib.types.enum ["glyph" "ascii"];
          default = "glyph";
          defaultText = "glyph";
          description = "The style to use for the icons.";
          example = lib.literalExpression ''
            {
              style = "ascii";
            }
          '';
        };

        # ## Categories to override icons
        # See: https://nvim-mini.org/mini.nvim/doc/mini-icons.html#miniicons.config-customizationpercategory
        default = mkCategoryOption "default";
        directory = mkCategoryOption "directory";
        file = mkCategoryOption "file";
        extension = mkCategoryOption "extension";
        filetype = mkCategoryOption "filetype";
        os = mkCategoryOption "os";
        lsp = mkCategoryOption "lsp";

        # ## Function which indicates whether using extension during file resolution
        # See: https://nvim-mini.org/mini.nvim/doc/mini-icons.html#miniicons.config-usingextensionduringfileresolution
        use_file_extension = lib.mkOption {
          type = lib.types.str;
          default = "function(ext, file) return true end";
          defaultText = "function(ext, file) return true end";
          description = "A function that returns true if the given file extension should be used for the icon.";
          example = lib.literalExpression ''
            function(ext, _)
              return ext == ".py" or ext == ".lua"
            end
          '';
        };
      };
    };
  };
}
