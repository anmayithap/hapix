_: let
  language-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      go
    ];
  };
in {
  flake.modules.darwin = {
    inherit language-programs;
  };
  flake.modules.nixos = {
    inherit language-programs;
  };
}
