_: let
  system-packages = {lib, ...}: {
    programs.zsh = {
      enable = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {inherit system-packages;};
  flake.modules.nixos = {inherit system-packages;};
}
