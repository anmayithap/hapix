# ----------------------------------------------------------------------------
# ## Generic Module: [Services]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.services = {
    imports = [
      inputs.self.modules.generic.sing-box
    ];
  };
}
