# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Colorscheme > ayu]
# Declaration
# ------------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.neovim = {
    lib,
    pkgs,
    ...
  }: let
    inherit (inputs.nvf.lib.nvim.types) mkPluginSetupOption;
  in {
    options.programs.nvf.settings.vim.hapix.colorscheme.ayu = {
      enable = lib.mkEnableOption "neovim-ayu";

      package = lib.mkPackageOption pkgs.vimPlugins "neovim-ayu" {
        default = "neovim-ayu";
        pkgsText = "pkgs.vimPlugins";
        extraDescription = ''
          This is package of neovim `ayu` color scheme.
          See: https://github.com/Shatur/neovim-ayu
        '';
      };

      vscode.enable = lib.mkEnableOption "vscode disabling wrapper";

      setupOpts = mkPluginSetupOption "neovim-ayu setup options" {
        # ## Overrides dark and light default ayu colorscheme to mirage
        mirage = lib.mkEnableOption "mirage colorscheme instead of dark";
        # ## Inject colorscheme into terminal
        terminal = lib.mkEnableOption "colorscheme for terminal";
        # ## Overrides highlighting groups
        # See: `:source $VIMRUNTIME/syntax/hitest.vim`
        overrides = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = {};
          defaultText = "{}";
          description = "Override highlighting groups";
          example = lib.literalExpression ''
            {
              Normal = {
                fg = "#abb2bf";
                bg = (lib.generators.mkLuaInline "colors.bg");
              };
              Comment = { italic = false; };
            }
          '';
        };
      };
    };
  };
}
