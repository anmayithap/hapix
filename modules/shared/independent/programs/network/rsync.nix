_: let
  network-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rsync
    ];
  };
in {
  flake.modules.darwin = {inherit network-programs;};
  flake.modules.nixos = {inherit network-programs;};
}
