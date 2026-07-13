# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > DAP]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.dap = {
      data = with pkgs.vimPlugins; [
        {
          inherit (nvim-dap) name pname;
          data = nvim-dap;
          lazy = lib.mkDefault false;
        }
        {
          inherit (nvim-dap-virtual-text) name pname;
          data = nvim-dap-virtual-text;
          lazy = lib.mkDefault true;
        }
        {
          inherit (nvim-dap-view) name pname;
          data = nvim-dap-view;
          lazy = lib.mkDefault false;
        }
      ];

      after = ["lze"];
    };
  };
}
