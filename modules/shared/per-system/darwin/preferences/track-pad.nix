# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Track Pad
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist` or `defaults read com.apple.AppleMultitouchTrackpad`
{
  flake.modules.darwin.track-pad = {lib, ...}: {
    system.defaults.trackpad = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.ActuateDetents
      ActuateDetents = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.ActuationStrength
      ActuationStrength = lib.mkDefault 1;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.Clicking
      Clicking = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.DragLock
      DragLock = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.Dragging
      Dragging = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.FirstClickThreshold
      FirstClickThreshold = lib.mkDefault 1;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.ForceSuppressed
      ForceSuppressed = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.SecondClickThreshold
      SecondClickThreshold = lib.mkDefault 1;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadCornerSecondaryClick
      # 0 - Disabled
      TrackpadCornerSecondaryClick = lib.mkDefault 0;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadFourFingerHorizSwipeGesture
      # 2 - Swipe between full-screen apps
      TrackpadFourFingerHorizSwipeGesture = lib.mkDefault 2;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadFourFingerPinchGesture
      # 2 - Enabled
      TrackpadFourFingerPinchGesture = lib.mkDefault 2;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadMomentumScroll
      TrackpadMomentumScroll = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadPinch
      TrackpadPinch = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadRightClick
      TrackpadRightClick = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadRotate
      TrackpadRotate = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadThreeFingerDrag
      TrackpadThreeFingerDrag = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadThreeFingerHorizSwipeGesture
      # 2 - Swipe between full-screen apps
      TrackpadThreeFingerHorizSwipeGesture = lib.mkDefault 2;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TraclpadThreeFingerTapGesture
      # 0 - Disabled
      TrackpadThreeFingerTapGesture = lib.mkDefault 0;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadThreeFingerVertSwipeGesture
      # 2 - Enabled
      TrackpadThreeFingerVertSwipeGesture = lib.mkDefault 2;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadTwoFingerDoubleTapGesture
      TrackpadTwoFingerDoubleTapGesture = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.trackpad.TrackpadTwoFingerFromLeftEdgeSwipeGesture
      TrackpadTwoFingerFromRightEdgeSwipeGesture = lib.mkDefault 3;
    };
  };
}
