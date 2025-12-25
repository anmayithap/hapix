_: let
  programs = {lib, ...}: {
    programs.sketchybar = {
      enable = lib.mkDefault true;
    };
  };
in {
  flake.modules.homeManager = {inherit programs;};
}
