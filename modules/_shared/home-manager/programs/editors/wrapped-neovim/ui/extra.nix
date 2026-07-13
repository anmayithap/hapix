# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Extra]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.ui-extra = with pkgs.vimPlugins; {
      data = [
        {
          inherit (mini-cursorword) name pname;
          data = mini-cursorword;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-hipatterns) name pname;
          data = mini-hipatterns;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-indentscope) name pname;
          data = mini-indentscope;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-map) name pname;
          data = mini-map;
          lazy = lib.mkDefault false;
        }
        {
          inherit (render-markdown-nvim) name pname;
          data = render-markdown-nvim;
          lazy = lib.mkDefault true;
        }
        {
          inherit (toggleterm-nvim) name pname;
          data = toggleterm-nvim;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-trailspace) name pname;
          data = mini-trailspace;
          lazy = lib.mkDefault false;
        }
      ];

      after = ["lze"];
    };
  };
}
