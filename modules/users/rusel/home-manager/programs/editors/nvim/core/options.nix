{
  flake.modules.homeManager.rusel-editors = {
    lib,
    config,
    ...
  }: let
    nvfConfig = config.programs.nvf.settings;
  in {
    programs.nvf = {
      settings = {
        vim = {
          ## Don't create:
          ##   - swap files
          ##   - back up files
          preventJunkFiles = lib.mkDefault true;
          ## Enable undo file for persistent undo behavior
          undoFile = {
            enable = lib.mkDefault true;
            path = lib.mkDefault "${config.xdg.dataHome}/nvim/undo";
          };
          ## Disable bells
          bell = lib.mkDefault "none";
          ## Configure how to line numbers are displayed:
          ##   - number: Set `number` option
          ##   - relative: Set `relativenumber` option
          ##   - relNumber: Set `relativenumber` and `number` options
          ##   - none: Disable line numbers
          lineNumberMode = lib.mkDefault "relNumber";
          ## Nvim default syntax highlighting
          ## Note: This is will be disabling if treesitter is enabled
          syntaxHighlighting = lib.mkDefault (!nvfConfig.vim.treesitter.highlight.enable);
          ## Set the case sensitivity of search to `smart`.
          searchCase = lib.mkDefault "smart";
          ## Enable search highlighting
          hideSearchHighlight = lib.mkDefault false;
          clipboard = {
            enable = lib.mkDefault true;
            registers = lib.mkDefault "unnamedplus";
          };
          options = {
            /*
            ------------------
            Interface settings
            ------------------
            */
            termguicolors = lib.mkDefault true; # Enable 24-bit RGB colors in the terminal
            cursorline = lib.mkDefault true; # Highlight the current line
            cursorlineopt = lib.mkDefault "number"; # Only row number highlighted
            signcolumn = lib.mkDefault "yes"; # Show column with signs
            showmode = lib.mkDefault false; # Don't show current mode
            /*
            --------------------------
            Scroll and cursor settings
            --------------------------
            */
            scrolloff = lib.mkDefault 8; # Scroll always by 8 lines when cursor is out of screen
            sidescrolloff = lib.mkDefault 8; # Scroll always by 8 columns when cursor is out of screen
            inccommand = lib.mkDefault "split"; # Killer Feature: preview incremental search at real time
            /*
            --------------------
            Indentation settings
            --------------------
            */
            tabstop = lib.mkDefault 4; # Tab width is 4 spaces
            softtabstop = lib.mkDefault 4; # Tab width is 4 spaces at insert mode
            shiftwidth = lib.mkDefault 4; # Tab width is 4 spaces at auto indent mode
            expandtab = lib.mkDefault true; # Tabs are expanded to spaces
            smartindent = lib.mkDefault true; # Smart indent on newline (for C-like languages)
            /*
            --------------------------
            Window and buffer settings
            --------------------------
            */
            splitbelow = lib.mkDefault true; # New window opens on bottom
            splitright = lib.mkDefault true; # New window opens on right
            hidden = lib.mkDefault true; # Allow switching buffers without saving
            /*
            ---------------
            System settings
            ---------------
            */
            mouse = lib.mkDefault "a"; # Enable mouse support
            updatetime = lib.mkDefault 250; # How often to update events (git gutter, swap, etc.)
            timeoutlen = lib.mkDefault 500; # Waiting time to next keypress at Leader key
            pumheight = lib.mkDefault 10; # Completion menu height
          };
        };
      };
    };
  };
}
