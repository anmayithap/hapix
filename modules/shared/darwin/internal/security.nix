_: let
  security = {lib, ...}: {
    security.pam.services.sudo_local = {
      reattach = lib.mkDefault true;
      touchIdAuth = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {inherit security;};
}
