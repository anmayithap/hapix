{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim = {
      globals = {
        mapleader = lib.mkDefault " ";
        maplocalleader = lib.mkDefault " ";
      };

      keymaps = lib.mkBefore [
        /*
        ---------------------------
        Discipline (Disable arrows)
        ---------------------------
        */
        {
          key = "<Up>";
          mode = ["n" "i" "v"];
          action = "<Nop>";
        }
        {
          key = "<Down>";
          mode = ["n" "i" "v"];
          action = "<Nop>";
        }
        {
          key = "<Left>";
          mode = ["n" "i" "v"];
          action = "<Nop>";
        }
        {
          key = "<Right>";
          mode = ["n" "i" "v"];
          action = "<Nop>";
        }
        /*
        ---------------
        File operations
        ---------------
        */
        {
          key = "<leader>w";
          mode = ["n"];
          action = ":w<CR>";
          silent = true;
          desc = "Save file";
        }
        {
          key = "<leader>q";
          mode = ["n"];
          action = ":q<CR>";
          silent = true;
          desc = "Quit";
        }
        {
          key = "<leader>qq";
          mode = ["n"];
          action = ":q!<CR>";
          silent = true;
          desc = "Force quit (discard changes)";
        }
        /*
        ------------------
        Sanitary standards
        ------------------
        */
        {
          key = "<Esc>";
          mode = ["n"];
          action = ":noh<CR>";
          silent = true;
          desc = "Clear search highlight";
        }
        /*
        -----------------
        Window navigation
        _________________
        */
        {
          key = "<C-h>";
          mode = ["n"];
          action = "<C-w>h";
          desc = "Window Left";
        }
        {
          key = "<C-j>";
          mode = ["n"];
          action = "<C-w>j";
          desc = "Window Down";
        }
        {
          key = "<C-k>";
          mode = ["n"];
          action = "<C-w>k";
          desc = "Window Up";
        }
        {
          key = "<C-l>";
          mode = ["n"];
          action = "<C-w>l";
          desc = "Window Right";
        }
        /*
        -------
        Editing
        -------
        */
        {
          key = "<Tab>";
          mode = ["n"];
          action = ">>";
          desc = "Right indentation";
        }
        {
          key = "<S-Tab>";
          mode = ["n"];
          action = "<<";
          desc = "Left indentation";
        }
      ];
    };
  };
}
