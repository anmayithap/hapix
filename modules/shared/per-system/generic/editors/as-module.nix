# ----------------------------------------------------------------------------
# ## Generic Module: [Editors]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.editors = {
    imports = [
      inputs.self.modules.generic.vim
    ];
  };
}
