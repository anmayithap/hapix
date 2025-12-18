_: let
  system-packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      go
    ];
  };
in {
  flake.modules.darwin = {inherit system-packages;};
  flake.modules.nixos = {inherit system-packages;};
}
