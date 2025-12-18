_: let
  system-packages = {lib, ...}: {
    programs.vim = {
      enable = lib.mkDefault true;
      enableSensible = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {inherit system-packages;};
  flake.modules.nixos = {inherit system-packages;};
}
