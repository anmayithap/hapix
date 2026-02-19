# ------------------------------------------------------------------------------
# Home Manager Module: [Programs > Editors > Neovim > Core > Options]
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    nvfConfig = config.programs.nvf.settings.vim;

    mkHapixDefault = lib.mkOrder 900;
  in {
    programs.nvf.settings.vim = {
      # ## Don't create:
      #   - swap files
      #   - back up files
      preventJunkFiles = mkHapixDefault true;
      # ## Enable undo file for persistent undo behavior
      undoFile = {
        enable = mkHapixDefault true;
        path = mkHapixDefault "${config.xdg.dataHome}/nvf/undo";
      };
      # ## Disable bells
      bell = mkHapixDefault "none";
      # ## Configure how to line numbers are displayed:
      #   - number: Set `number` option
      #   - relative: Set `relativenumber` option
      #   - relNumber: Set `relativenumber` and `number` options
      #   - none: Disable line numbers
      lineNumberMode = mkHapixDefault "relNumber";
      # ## Neovim default syntax highlighting
      # Note: This is will be disabling if treesitter is enabled
      syntaxHighlighting = mkHapixDefault (!nvfConfig.treesitter.highlight.enable);
      # ## Set the case sensitivity of search to `smart`.
      searchCase = mkHapixDefault "smart";
      # ## Disable search highlighting
      hideSearchHighlight = mkHapixDefault false;
      # ## Configure clipboard to `unnamedplus` register
      clipboard = {
        enable = mkHapixDefault true;
        registers = mkHapixDefault (lib.mkLuaInline ''vim.env.SSH_CONNECTION and "" or "unnamedplus"'');
      };
      options = {
        # -------------------------
        # ## Auto Behavior settings
        # -------------------------
        autochdir = mkHapixDefault false; # When this option is `on` some plugins may not work
        autoread = mkHapixDefault true; # Auto read file when changed
        autowrite = mkHapixDefault false; # Auto write file when changed
        autowriteall = mkHapixDefault false; # Auto write all file when changed
        # -------------------------
        # ## Visualization settings
        # -------------------------
        background = mkHapixDefault "dark";
        # ## Concealed text is completely hidden
        # unless it has a custom replacement character defined
        conceallevel = mkHapixDefault 2;
        termguicolors = mkHapixDefault true; # Enable 24-bit RGB colors
        cursorline = mkHapixDefault true; # Highlight the current line
        cursorlineopt = mkHapixDefault "number"; # Only row number highlighted
        signcolumn = mkHapixDefault "yes"; # Show column with signs
        fillchars = mkHapixDefault "foldopen:,foldclose:,fold: ,foldsep: ,diff:/";
        foldmethod = mkHapixDefault "indent";
        foldtext = mkHapixDefault "";
        inccommand = mkHapixDefault "split"; # Preview incremental substitution
        jumpoptions = mkHapixDefault "view";
        # ## Status line visualization behavior
        #   - 0: never
        #   - 1: only if there are at least two windows
        #   - 2: always
        #   - 3: always and ONLY the last window
        laststatus = mkHapixDefault 3;
        linebreak = mkHapixDefault true; # Wrap lines at convenient points
        list = mkHapixDefault true; # Show some invisible characters (tabs, ...)
        number = mkHapixDefault true; # Show line numbers
        pumblend = mkHapixDefault 10; # Popup menu transparency (0-100)
        pumheight = mkHapixDefault 10; # Completion menu height
        relativenumber = mkHapixDefault true; # Show relative line numbers
        ruler = mkHapixDefault false; # Disable the default ruler
        scrolloff = mkHapixDefault 10; # Lines of context
        # ## Short message suppression
        #   - l: use "999L, 888B" instead of "999 lines, 888 bytes"
        #   - m: use "[+]" instead of "[Modified]"
        #   - r: use "[RO]" instead of "[readonly]"
        #   - w: use "[w]" instead of "written" for file write message
        #     and "[a]" instead of "appended" for ':w >> file' command
        #   - a: all of the above abbreviations
        #   - o: overwrite message for writing a file with subsequent
        #     message for reading a file (useful for ":wn" or when 'autowrite' on)
        #   - O: message for reading a file overwrites any previous message;
        #     also for quickfix message (e.g., ":cn")
        #   - s: don't give "search hit BOTTOM, continuing at TOP" or
        #     "search hit TOP, continuing at BOTTOM" messages; when using
        #     the search count do not show "W" before the count message
        #     (see |shm-S| below)
        #   - t: truncate file message at the start if it is too long
        #     to fit on the command-line, "<" will appear in the left most
        #     column; ignored in Ex mode
        #   - T: truncate other messages in the middle if they are too
        #     long to fit on the command line; "..." will appear in the
        #     middle; ignored in Ex mode
        #   - W: don't give "written" or "[w]" when writing a file
        #   - A: don't give the "ATTENTION" message when an existing
        #     swap file is found
        #   - I: don't give the intro message when starting Vim,
        #     see |:intro|
        #   - c: don't give |ins-completion-menu| messages; for
        #     example, "-- XXX completion (YYY)", "match 1 of 2", "The only
        #     match", "Pattern not found", "Back at original", etc.
        #   - C: don't give messages while scanning for ins-completion
        #     items, for instance "scanning tags"
        #   - q: do not show "recording @a" when recording a macro
        #   - F: don't give the file info when editing a file, like
        #     `:silent` was used for the command; note that this also
        #     affects messages from 'autoread' reloading
        #   - S: do not show search count message when searching, e.g.
        #     "[1/5]". When the "S" flag is not present (e.g. search count
        #     is shown), the "search hit BOTTOM, continuing at TOP" and
        #     "search hit TOP, continuing at BOTTOM" messages are only
        #     indicated by a "W" (Mnemonic: Wrapped) letter before the
        #     count message.
        shortmess = mkHapixDefault "lmrwoOtTWIcCF";
        showmode = mkHapixDefault false; # Don't show current mode (show in statusline)
        sidescrolloff = mkHapixDefault 8; # Columns of context
        smoothscroll = mkHapixDefault true; # Smooth scrolling
        breakindent = mkHapixDefault true; # Indent wrapped lines
        wrap = mkHapixDefault true; # Wrap lines at convenient points
        showtabline = mkHapixDefault 2; # Always show tabline
        listchars = mkHapixDefault "tab:» ,trail:·,nbsp:␣,extends:…";
        # ------------------
        # ## Buffer settings
        # ------------------
        bufhidden = mkHapixDefault "hide";
        buflisted = mkHapixDefault true;
        hidden = mkHapixDefault true; # Allow switching buffers without saving
        # ----------------------
        # ## Completion settings
        # ----------------------
        completeopt = mkHapixDefault "menu,menuone,noselect,preinsert,preview";
        wildmode = mkHapixDefault "longest:full,full";
        wildoptions = mkHapixDefault "pum"; # Popup menu for wildmode
        # ------------------
        # ## System settings
        # ------------------
        confirm = mkHapixDefault true;
        mouse = mkHapixDefault "a"; # Enable mouse support
        timeoutlen = mkHapixDefault (lib.mkLuaInline ''vim.g.vscode and 1000 or 500'');
        updatetime = mkHapixDefault 250; # Save swap file and trigger CursorHold event
        # ----------------------------
        # ## Editing Behavior settings
        # ----------------------------
        expandtab = mkHapixDefault true; # Use spaces instead of tabs
        shiftround = mkHapixDefault true; # Round indent to multiple of shiftwidth
        shiftwidth = mkHapixDefault 4; # Tab width is 4 spaces
        smartindent = mkHapixDefault true; # Smart indent on newline (for C-like languages)
        tabstop = mkHapixDefault 4; # Number of spaces tabs count for
        # ---------------------------
        # ## Search behavior settingszh
        # ---------------------------
        ignorecase = mkHapixDefault true; # Ignore case when searching
        smartcase = mkHapixDefault true; # Don't ignore case with capitals
        # --------------------------
        ## Session behavior settings
        # --------------------------
        sessionoptions = mkHapixDefault "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds,winpos";
        # --------------------
        # ## Spelling settings
        # --------------------
        spell = mkHapixDefault true; # Enable spell checking
        spelllang = mkHapixDefault "en"; # Available spell languages
        # ---------------------------
        # ## Window behavior settings
        # ---------------------------
        splitbelow = mkHapixDefault true; # Put new window below current
        splitkeep = mkHapixDefault "screen"; # Keep window layout
        splitright = mkHapixDefault true; # Put new window right of current
        winminwidth = mkHapixDefault 5;
        # ------------------------------
        # ## Selection behavior settings
        # ------------------------------
        virtualedit = mkHapixDefault "block";
      };
    };
  };
}
