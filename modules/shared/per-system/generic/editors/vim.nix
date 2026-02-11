# ----------------------------------------------------------------------------
# ## Generic Module: [Editors > Vim]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.vim = {lib, ...}: {
    programs.vim = {
      enable = lib.mkDefault false;
    };
  };
}
