_: let
  shell-programs = {lib, ...}: {
    programs.zsh = {
      enable = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {inherit shell-programs;};
  flake.modules.nixos = {inherit shell-programs;};
}
