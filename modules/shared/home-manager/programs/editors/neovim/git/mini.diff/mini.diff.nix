# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Git > Mini.diff]
# ------------------------------------------------------------------------------
# See: https://nvim-mini.org/mini.nvim/doc/mini-diff.html
{
  flake.modules.homeManager.neovim = {lib, ...}: {
    programs.nvf.settings.vim.mini.diff = {
      enable = lib.mkDefault true;

      setupOpts = {
        view = {
          # ## Can be one of:
          #   - 'number'  (colored line number)
          #   - 'sign'    (colored sign in a sign-column)
          style = lib.mkDefault (lib.generators.mkLuaInline "vim.go.number and 'number' or 'sign'");
          signs = lib.mkDefault {
            add = lib.mkDefault "▎";
            change = lib.mkDefault "▎";
            delete = lib.mkDefault "";
          };
          # ## Default: 199 which is one less than user in vim.hl.priorities
          priority = lib.mkDefault 199;
        };

        # ## Source(s) for how reference text is computed/updated/etc
        # Uses content from Git index by default.
        source = lib.mkDefault null;

        # ## Contains settings for delays in asynchronous processes
        delay = {
          text_change = lib.mkDefault 200; # in ms
        };

        mappings = {
          apply = lib.mkDefault "gh";
          reset = lib.mkDefault "gH";
          textobject = lib.mkDefault "gh";
          goto_first = lib.mkDefault "[H";
          goto_prev = lib.mkDefault "[h";
          goto_next = lib.mkDefault "]h";
          goto_last = lib.mkDefault "]H";
        };

        options = {
          # ## See: https://neovim.io/doc/user/lua.html#vim.text.diff()
          algorithm = lib.mkDefault "histogram";
          indent_heuristic = lib.mkDefault true;
          linematch = lib.mkDefault 120;
          # ## Indicating whether to wrap around edges during hunk navigation
          wrap_goto = lib.mkDefault true;
        };
      };
    };
  };
}
