_: let
  wsl = {lib, ...}: {
    wsl.enable = lib.mkDefault true;
  };
in {
  flake.modules.nixos = {inherit wsl;};
}
