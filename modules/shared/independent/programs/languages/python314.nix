_: let
  language-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      python314
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
