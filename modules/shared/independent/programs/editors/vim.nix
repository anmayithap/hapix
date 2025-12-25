_: let
  editor-programs = {lib, ...}: {
    programs.vim = {
      enable = lib.mkDefault true;
      enableSensible = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {
    inherit editor-programs;
  };
  flake.modules.nixos = {
    inherit editor-programs;
  };
}
