# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Keyboard]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.keyboard = {
    imports = [
      inputs.self.modules.homeManager.skhd
    ];
  };
}
