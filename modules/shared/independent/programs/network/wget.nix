_: let
  network-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wget
    ];
  };
in {
  flake.modules.darwin = {inherit network-programs;};
  flake.modules.nixos = {inherit network-programs;};
}
