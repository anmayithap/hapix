# ------------------------------------------------------------------------------
# Home Manager Module: [Programs > Editors > Neovim > Core > Keymaps]
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {lib, ...}: let
    mkHapixDefault = lib.mkOrder 900;
  in {
    programs.nvf.settings.vim = {
      globals = {
        # ## Global key map namespace
        mapleader = mkHapixDefault " ";
        # ## Local key map namespace
        maplocalleader = mkHapixDefault ",";
      };

      keymaps = lib.mkBefore [
        # ----------
        # ## General
        # ----------
        {
          key = "<Esc>";
          mode = ["n"];
          action = "<cmd>nohlsearch<CR>";
          desc = "Clear search highlight";
          unique = true;
        }
        # -----------------
        # ## Disable arrows
        # -----------------
        # Note: Disable only for normal, insert and visual modes
        {
          key = "<Up>";
          mode = ["n" "i" "v" "x"];
          action = "<Nop>";
        }
        {
          key = "<Down>";
          mode = ["n" "i" "v" "x"];
          action = "<Nop>";
        }
        {
          key = "<Left>";
          mode = ["n" "i" "v" "x"];
          action = "<Nop>";
        }
        {
          key = "<Right>";
          mode = ["n" "i" "v" "x"];
          action = "<Nop>";
        }
        # ----------------
        ## +(b)uffer Group
        # ----------------
        {
          key = "<leader>b";
          mode = ["n"];
          action = "<Nop>";
          desc = "+Buffer";
          unique = true;
        }
        # ## Creation, Saving, Switching, Info
        {
          key = "<leader>bn";
          mode = ["n"];
          action = "<cmd>enew<CR>";
          desc = "New empty buffer";
          unique = true;
        }
        {
          key = "<leader>bs";
          mode = ["n"];
          action = "<cmd>update<CR>";
          desc = "Save (update) buffer";
          unique = true;
        }
        {
          key = "<leader>bsa";
          mode = ["n"];
          action = "<cmd>wa<CR>";
          desc = "Save all buffers";
          unique = true;
        }
        {
          key = "<leader>bl";
          mode = ["n"];
          action = "<cmd>buffers<CR>";
          desc = "List buffers";
          unique = true;
        }
        {
          key = "<leader>bb";
          mode = ["n"];
          action = "<cmd>e#<CR>";
          desc = "Switch to other buffer";
          unique = true;
        }
        # ## Navigation
        {
          key = "<leader>b]";
          mode = ["n"];
          action = "<cmd>bnext<CR>";
          desc = "Select next buffer";
          unique = true;
        }
        {
          key = "<leader>b[";
          mode = ["n"];
          action = "<cmd>bprevious<CR>";
          desc = "Select previous buffer";
          unique = true;
        }
        # ## Lifecycle (Delete)
        {
          key = "<leader>bd";
          mode = ["n"];
          action = "<cmd>bd<CR>";
          desc = "Delete buffer";
        }
        {
          key = "<leader>bda";
          mode = ["n"];
          action = "<cmd>bufdo bd<CR>";
          desc = "Delete all buffers";
          unique = true;
        }
        {
          key = "<leader>bdo";
          mode = ["n"];
          action = "<cmd>%bd|e#|bd#<CR>";
          desc = "Delete other buffers";
        }
        # ## Lifecycle (Unload)
        {
          key = "<leader>bc";
          mode = ["n"];
          action = "<cmd>bun<CR>";
          desc = "Unload buffer";
        }
        {
          key = "<leader>bca";
          mode = ["n"];
          action = "<cmd>bufdo bun<CR>";
          desc = "Unload all buffers";
          unique = true;
        }
        {
          key = "<leader>bco";
          mode = ["n"];
          action = "<cmd>%bun|e#|bun#<CR>";
          desc = "Unload other buffers";
        }
        # ## Lifecycle (Wipeout)
        {
          key = "<leader>bq";
          mode = ["n"];
          action = "<cmd>bw<CR>";
          desc = "Wipeout buffer";
        }
        {
          key = "<leader>bqa";
          mode = ["n"];
          action = "<cmd>bufdo bw<CR>";
          desc = "Wipeout all buffers";
          unique = true;
        }
        {
          key = "<leader>bqo";
          mode = ["n"];
          action = "<cmd>%bw|e#|bw#<CR>";
          desc = "Wipeout other buffers";
        }
        # ------------------
        # ## +(w)indow Group
        # ------------------
        {
          key = "<leader>w";
          mode = ["n"];
          action = "<Nop>";
          desc = "+Window";
          unique = true;
        }
        # ## Splitting
        {
          key = "<leader>ws";
          mode = ["n"];
          action = "<cmd>split<CR>";
          desc = "Split horizontal";
          unique = true;
        }
        {
          key = "<leader>wv";
          mode = ["n"];
          action = "<cmd>vsplit<CR>";
          desc = "Split vertical";
          unique = true;
        }
        # ## Navigation
        {
          key = "<leader>wh";
          mode = ["n"];
          action = "<C-w>h";
          desc = "Focus window left";
          unique = true;
        }
        {
          key = "<leader>wj";
          mode = ["n"];
          action = "<C-w>j";
          desc = "Focus window bottom";
          unique = true;
        }
        {
          key = "<leader>wk";
          mode = ["n"];
          action = "<C-w>k";
          desc = "Focus window top";
          unique = true;
        }
        {
          key = "<leader>wl";
          mode = ["n"];
          action = "<C-w>l";
          desc = "Focus window right";
          unique = true;
        }
        # ## Lifecycle
        {
          key = "<leader>wc";
          mode = ["n"];
          action = "<cmd>close<CR>";
          desc = "Close window";
          unique = true;
        }
        {
          key = "<leader>wo";
          mode = ["n"];
          action = "<cmd>only<CR>";
          desc = "Close other windows";
          unique = true;
        }
        {
          key = "<leader>w=";
          mode = ["n"];
          action = "<C-w>=";
          desc = "Equalize size";
          unique = true;
        }
        # ## Resizing (Height)
        {
          key = "<leader>w+";
          mode = ["n"];
          action = "<cmd>resize +2<CR>";
          desc = "Increase height";
          unique = true;
        }
        {
          key = "<leader>w-";
          mode = ["n"];
          action = "<cmd>resize -2<CR>";
          desc = "Decrease height";
          unique = true;
        }
        # ## Resizing (Width)
        {
          key = "<leader>w>";
          mode = ["n"];
          action = "<cmd>vertical resize +2<CR>";
          desc = "Increase width";
          unique = true;
        }
        {
          key = "<leader>w<";
          mode = ["n"];
          action = "<cmd>vertical resize -2<CR>";
          desc = "Decrease width";
          unique = true;
        }
        # ---------------
        # ## +(t)ab Group
        # ---------------
        {
          key = "<leader>t";
          mode = ["n"];
          action = "<Nop>";
          desc = "+Tab (Workspaces)";
          unique = true;
        }
        # ## Creating, Saving, Info
        {
          key = "<leader>tn";
          mode = ["n"];
          action = "<cmd>tabnew<CR>";
          desc = "New tab";
          unique = true;
        }
        # ## Lifecycle
        {
          key = "<leader>tc";
          mode = ["n"];
          action = "<cmd>tabclose<CR>";
          desc = "Close tab";
          unique = true;
        }
        {
          key = "<leader>to";
          mode = ["n"];
          action = "<cmd>tabonly<CR>";
          desc = "Close other tabs";
          unique = true;
        }
        # ## Navigation
        {
          key = "<leader>t]";
          mode = ["n"];
          action = "<cmd>tabnext<CR>";
          desc = "Next tab";
          unique = true;
        }
        {
          key = "<leader>t[";
          mode = ["n"];
          action = "<cmd>tabprevious<CR>";
          desc = "Previous tab";
          unique = true;
        }
        {
          key = "<leader>tl";
          mode = ["n"];
          action = "<cmd>tablast<CR>";
          desc = "Go to last tab";
          unique = true;
        }
        {
          key = "<leader>th";
          mode = ["n"];
          action = "<cmd>tabfirst<CR>";
          desc = "Go to first tab";
          unique = true;
        }
        # ------------------
        # ## +(s)ession Group
        # ------------------
        {
          key = "<leader>s";
          mode = ["n"];
          action = "<Nop>";
          desc = "+Session";
          unique = true;
        }
        # ## Lifecycle
        {
          key = "<leader>ss";
          mode = ["n"];
          action = "<cmd>wa<CR>";
          desc = "Save all buffers";
          unique = true;
        }
        {
          key = "<leader>sq";
          mode = ["n"];
          action = "<cmd>qa<CR>";
          desc = "Quit Neovim";
          unique = true;
        }
        {
          key = "<leader>sqf";
          mode = ["n"];
          action = "<cmd>qa!<CR>";
          desc = "Quit Neovim (Force)";
          unique = true;
        }
        {
          key = "<leader>sx";
          mode = ["n"];
          action = "<cmd>wqa<CR>";
          desc = "Save and quit Neovim";
          unique = true;
        }
        {
          key = "<leader>sxf";
          mode = ["n"];
          action = "<cmd>wqa!<CR>";
          desc = "Save and quit Neovim (Force)";
          unique = true;
        }
        # ---------------
        # ## +(g)it Group
        # ---------------
        {
          key = "<leader>g";
          mode = ["n" "v"];
          action = "<Nop>";
          desc = "+Git";
          unique = true;
        }
      ];
    };
  };
}
