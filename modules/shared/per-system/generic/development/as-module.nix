# ----------------------------------------------------------------------------
# ## Development Module: Importing all development modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.development = {
    imports = [
      inputs.self.modules.generic.golang
      inputs.self.modules.generic.python
    ];
  };
}
