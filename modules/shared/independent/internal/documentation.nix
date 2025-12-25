_: let
  documentation = {lib, ...}: {
    documentation = {
      enable = lib.mkDefault false;
      doc.enable = lib.mkDefault false;
      info.enable = lib.mkDefault false;
    };
  };
in {
  flake.modules.nixos = {inherit documentation;};
  flake.modules.darwin = {inherit documentation;};
}
