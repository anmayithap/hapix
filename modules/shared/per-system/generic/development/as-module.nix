# ----------------------------------------------------------------------------
# ## Generic Module: [Development]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.development = {
    imports = [
      inputs.self.modules.generic.golang
      inputs.self.modules.generic.python
    ];
  };
}
