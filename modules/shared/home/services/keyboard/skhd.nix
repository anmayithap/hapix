_: let
  services = {lib, ...}: {
    services.skhd = {
      enable = lib.mkDefault true;
      config = lib.mkBefore '''';
    };
  };
in {
  flake.modules.homeManager = {inherit services;};
}
