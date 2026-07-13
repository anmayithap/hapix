# ----------------------------------------------------------------------------
# ## Generic Module: [Utils]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.utils = {
    imports = [
      inputs.self.modules.generic.httpie
      inputs.self.modules.generic.nh
      inputs.self.modules.generic.rsync
      inputs.self.modules.generic.wget
    ];
  };
}
