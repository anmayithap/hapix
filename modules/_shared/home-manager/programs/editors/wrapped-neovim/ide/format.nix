# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > Format]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.format = {
      postPkgs = with pkgs; [
        prettierd # json, markdown, yaml, css, etc. formatter
        shfmt # shell formatter
        taplo # toml formatter
      ];

      data = with pkgs.vimPlugins; [
        {
          inherit (conform-nvim) name pname;
          data = conform-nvim;
          lazy = lib.mkDefault true;
        }
      ];
      after = ["lze"];
    };
  };
}
