# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Colorscheme]
# Declaration
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {lib, ...}: {
    options.programs.nvf.settings.vim.hapix.colorscheme = {
      default = lib.mkOption {
        type = lib.types.enum ["ayu"];
        default = "ayu";
        defaultText = "ayu";
        description = "Default colorscheme";
        example = "ayu";
      };
    };
  };
}
