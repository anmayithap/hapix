_: let
  system-packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      python314
    ];
  };
in {
  flake.modules.darwin = {inherit system-packages;};
  flake.modules.nixos = {inherit system-packages;};
}
