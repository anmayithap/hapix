# ----------------------------------------------------------------------------
# ## Darwin Module: [Preferences]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.darwin.preferences = {
    imports = [
      inputs.self.modules.darwin.activity-monitor
      inputs.self.modules.darwin.control-center
      inputs.self.modules.darwin.dock
      inputs.self.modules.darwin.extra-clock
      inputs.self.modules.darwin.finder
      inputs.self.modules.darwin.firewall
      inputs.self.modules.darwin.global
      inputs.self.modules.darwin.hi-tool-box
      inputs.self.modules.darwin.homebrew
      inputs.self.modules.darwin.keyboard
      inputs.self.modules.darwin.launch
      inputs.self.modules.darwin.login-window
      inputs.self.modules.darwin.networking
      inputs.self.modules.darwin.ns-global-domain
      inputs.self.modules.darwin.power
      inputs.self.modules.darwin.screen-capture
      inputs.self.modules.darwin.security
      inputs.self.modules.darwin.software-update
      inputs.self.modules.darwin.track-pad
      inputs.self.modules.darwin.window-manager
    ];
  };
}
