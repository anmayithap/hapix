_: let
  system-packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      httpie
    ];
  };
in {
  flake.modules.darwin = {inherit system-packages;};
  flake.modules.nixos = {inherit system-packages;};
}
