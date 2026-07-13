# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Languages > Python]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.python = {
      postPkgs = [
        # ## LSP
        pkgs.basedpyright
        pkgs.ruff
      ];

      data = with pkgs.vimPlugins; [
        {
          inherit (nvim-dap-python) name pname;
          data = nvim-dap-python;
          lazy = lib.mkDefault false;

          after = [
            "dap"
          ];
        }
        {
          inherit (venv-selector-nvim) name pname;
          data = venv-selector-nvim;
          lazy = lib.mkDefault false;
        }
      ];

      after = ["lze"];
    };
  };
}
