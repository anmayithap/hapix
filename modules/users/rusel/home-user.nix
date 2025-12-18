{inputs, ...}: let
  home.home-manager.users.rusel.imports = [
    inputs.self.homeModules.rusel
  ];

  flake.modules.darwin.rusel.imports = [
    inputs.self.modules.darwin.home-manager
    home
  ];
in {
  inherit flake;
}
