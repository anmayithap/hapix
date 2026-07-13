# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Languages > Lua]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {pkgs, ...}: {
    wrappers.neovim.specs.lua = {
      postPkgs = [
        # ## LSP
        pkgs.lua-language-server
        # ## Formatters
        pkgs.stylua
      ];

      data = [
        {
          inherit (pkgs.vimPlugins.lazydev-nvim) name pname;
          data = pkgs.vimPlugins.lazydev-nvim;

          lazy = true;
        }
      ];

      after = ["lze"];
    };
  };
}
