# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > Syntax]
# -----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.syntax = {
      postPkgs = [
        inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.tree-sitter
      ];

      data = with pkgs.vimPlugins; [
        {
          inherit (nvim-treesitter) name pname;
          data = nvim-treesitter.withAllGrammars;
          lazy = lib.mkDefault false;
        }
        {
          inherit (nvim-treesitter-textobjects) name pname;
          data = nvim-treesitter-textobjects;
          lazy = lib.mkDefault false;
        }
        {
          inherit (nvim-treesitter-context) name pname;
          data = nvim-treesitter-context;
          lazy = lib.mkDefault false;
        }
      ];
      after = ["lze"];
    };
  };
}
