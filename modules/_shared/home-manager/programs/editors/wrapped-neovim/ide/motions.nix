# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Ide > Motions]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.motions = {
      data = with pkgs.vimPlugins; [
        {
          inherit (mini-ai) name pname;
          data = mini-ai;
          lazy = lib.mkDefault false;

          after = [
            "helpers-extra"
          ];
        }
        {
          inherit (mini-comment) name pname;
          data = mini-comment;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-move) name pname;
          data = mini-move;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-operators) name pname;
          data = mini-operators;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-splitjoin) name pname;
          data = mini-splitjoin;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-surround) name pname;
          data = mini-surround;
          lazy = lib.mkDefault false;
        }
        {
          inherit (mini-jump) name pname;
          data = mini-jump;
          lazy = lib.mkDefault false;
        }
        {
          inherit (leap-nvim) name pname;
          data = leap-nvim;
          lazy = lib.mkDefault false;
        }
      ];

      after = ["lze"];
    };
  };
}
