_: let
  system = {lib, ...}: {
    system.defaults.trackpad = {
      Clicking = lib.mkDefault true;
      Dragging = lib.mkDefault true;
      FirstClickThreshold = lib.mkDefault 1;
      SecondClickThreshold = lib.mkDefault 1;
      TrackpadRightClick = lib.mkDefault true;
      TrackpadThreeFingerDrag = lib.mkDefault false;
      TrackpadThreeFingerTapGesture = lib.mkDefault 0;
      ActuationStrength = lib.mkDefault 1;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
