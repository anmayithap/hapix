# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Icons > mini.icons]
# ------------------------------------------------------------------------------
# See: https://nvim-mini.org/mini.nvim/doc/mini-icons.html
{
  flake.modules.homeManager.neovim = {lib, ...}: {
    programs.nvf.settings.vim.hapix.mini.icons = {
      enable = lib.mkDefault true;

      vscode.enable = lib.mkDefault true;

      hooks = {
        mock_nvim_web_devicons.enable = lib.mkDefault true;
        tweak_lsp_kind = {
          enable = lib.mkDefault true;
          mode = lib.mkDefault "prepend";
        };
      };

      setupOpts = {
        style = lib.mkDefault "glyph";
        use_file_extension = lib.mkDefault ''
          function(ext, _)
            local suf3, suf4 = ext:sub(-3), ext:sub(-4)
            return suf3 ~= "scm" and suf3 ~= "txt" and suf3 ~= "yml" and suf4 ~= "json" and suf4 ~= "yaml"
          end
        '';
      };
    };
  };
}
