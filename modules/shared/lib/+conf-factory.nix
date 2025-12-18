{
  inputs,
  lib,
  ...
}: let
  mkLinuxDecorator = system: class: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        inputs.self.modules.nixos.${class}
        inputs.self.modules.nixos.${name}
        {
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = "25.11";
        }
      ];
    };

  mkDarwinDecorator = system: class: name:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;

      modules = [
        inputs.self.modules.darwin.${class}
        inputs.self.modules.darwin.${name}
        {
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = 6;
        }
      ];
    };

  mkLinuxWSL = mkLinuxDecorator "x86_64-linux" "wsl";
  mkLinux = mkLinuxDecorator "x86_64-linux" "nixos";

  mkDarwin = mkDarwinDecorator "x86_64-darwin" "darwin";
in {
  flake = {
    lib = {
      conf-factory = {
        inherit
          mkLinuxDecorator
          mkDarwinDecorator
          ;

        inherit
          mkLinuxWSL
          mkLinux
          mkDarwin
          ;
      };
    };
  };
}
