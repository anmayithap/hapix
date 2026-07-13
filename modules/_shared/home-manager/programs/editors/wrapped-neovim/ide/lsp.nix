# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > LSP]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.lsp = {
      postPkgs = with pkgs; [
        # ## LSP
        harper # harper-ls
        taplo # taplo-lsp
        typos-lsp # typos-lsp
        vscode-json-languageserver # json-lsp
        yaml-language-server # yaml-lsp
        marksman # marksman-lsp

        # ## Linters
        shellcheck # shell linter
        hadolint # dockerfile linter
      ];

      data = with pkgs.vimPlugins; [
        {
          inherit (nvim-lspconfig) name pname;
          data = nvim-lspconfig;
          lazy = lib.mkDefault false;
        }
        {
          inherit (nvim-lint) name pname;
          data = nvim-lint;
          lazy = lib.mkDefault true;
        }
      ];

      after = ["lze"];
    };
  };
}
