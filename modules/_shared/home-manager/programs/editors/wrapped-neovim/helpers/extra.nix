# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Extra]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.helpers-extra = with pkgs.vimPlugins; {
      data = [
        {
          inherit (vim-be-good) name pname;
          data = vim-be-good;
          lazy = lib.mkDefault true;
        }
        {
          inherit (mini-bracketed) name pname;
          data = mini-bracketed;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-bufremove) name pname;
          data = mini-bufremove;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-cmdline) name pname;
          data = mini-cmdline;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-extra) name pname;
          data = mini-extra;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-keymap) name pname;
          data = mini-keymap;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-pairs) name pname;
          data = mini-pairs;
          lazy = lib.mkDefault false;
        }
        {
          inherit (quicker-nvim) name pname;
          data = quicker-nvim;
          lazy = lib.mkDefault true;
        }
        {
          inherit (overseer-nvim) name pname;
          data = overseer-nvim;
          lazy = lib.mkDefault true;
        }
        {
          inherit (mini-visits) name pname;
          data = mini-visits;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-misc) name pname;
          data = mini-misc;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-test) name pname;
          data = mini-test;
          lazy = lib.mkDefault false;
        }
      ];

      after = ["lze"];
    };
  };
}
