# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > Test]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim.specs.test = {
      data = with pkgs.vimPlugins; [
        {
          inherit (neotest) name pname;
          data = neotest;
          lazy = lib.mkDefault false;

          after = [
            "syntax"
          ];
        }
      ];
      after = ["lze"];
    };
  };
}
