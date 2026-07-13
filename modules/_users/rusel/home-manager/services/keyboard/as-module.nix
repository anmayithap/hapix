# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Services > Keyboard]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-keyboard = {
    imports = [
      inputs.self.modules.homeManager.rusel-skhd
    ];
  };
}
