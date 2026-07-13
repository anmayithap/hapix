# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Explorer]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.explorer = {
      enable = lib.mkDefault true;
      default = lib.mkDefault "as_buffer";

      as_tree = {
        enable = lib.mkDefault true;
        name = lib.mkDefault "mini.files";
        pname = lib.mkDefault "mini.files";
      };

      as_buffer = {
        enable = lib.mkDefault true;
        name = lib.mkDefault "oil";
        pname = lib.mkDefault "oil.nvim";
      };
    };
  };
}
