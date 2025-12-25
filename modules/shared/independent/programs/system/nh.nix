_: let
  system-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nh
    ];
  };
in {
  flake.modules.darwin = {inherit system-programs;};
  flake.modules.nixos = {inherit system-programs;};
}
