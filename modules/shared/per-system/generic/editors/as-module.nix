# ----------------------------------------------------------------------------
# ## Editors Module: Importing all editors modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.editors = {
    imports = [
      inputs.self.modules.generic.vim
    ];
  };
}
