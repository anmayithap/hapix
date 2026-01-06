# =========================================================================
# == SHARED LIBRARY: Configuration Factory (conf-factory)
# This module defines the high-level "factories" used to instantiate
# NixOS and Darwin systems. It abstracts the boilerplate of system
# definition, enforcing a consistent structure by combining base
# profiles (classes) with specific machine configurations (names).
# =========================================================================
{
  inputs,
  lib,
  ...
}: let
  # -----------------------------------------------------------------------
  # ## NixOS Configuration Factory (Linux)
  # -----------------------------------------------------------------------
  # A decorator that produces a full NixOS system.
  # Params:
  # - `system`: The architecture (e.g., "x86_64-linux").
  # - `class`: The base profile to use (e.g., "nixos" or "wsl").
  # - `name`: The specific host identifier (e.g., "maple-linux").
  mkLinuxDecorator = system: class: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        # Pulls the base profile (Class) from the shared registry.
        inputs.self.modules.nixos.${class}

        # Pulls the host-specific settings (Name) from the shared registry.
        inputs.self.modules.nixos.${name}

        {
          nixpkgs = {
            hostPlatform = lib.mkDefault system;

            overlays = [
              (final: _: {
                stable = import inputs.nixpkgs-stable {
                  inherit (final.stdenv.hostPlatform) system;
                  inherit (final) config;
                };
              })
            ];
          };

          # The state version for the latest NixOS release (2025.11).
          # This ensures compatibility with data created on this version.
          system.stateVersion = "25.11";
        }
      ];
    };

  # -----------------------------------------------------------------------
  # ## Darwin Configuration Factory (macOS)
  # -----------------------------------------------------------------------
  # A decorator that produces a full nix-darwin system.
  mkDarwinDecorator = system: class: name:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;

      modules = [
        # Pulls the base Darwin profile (e.g., "darwin").
        inputs.self.modules.darwin.${class}

        # Pulls the specific macOS host configuration.
        inputs.self.modules.darwin.${name}

        {
          nixpkgs = {
            hostPlatform = lib.mkDefault system;

            overlays = [
              (final: _: {
                stable = import inputs.nixpkgs-stable {
                  inherit (final.stdenv.hostPlatform) system;
                  inherit (final) config;
                };
              })
            ];
          };

          # The standard state version for current nix-darwin installations.
          system.stateVersion = 6;
        }
      ];
    };

  # -----------------------------------------------------------------------
  # ## Specialized Factory Helpers
  # -----------------------------------------------------------------------
  # These pre-applied (curried) functions provide a simpler API for the
  # most common system types in our infrastructure.

  # Instantiates a WSL instance on x86_64.
  mkLinuxWSL = mkLinuxDecorator "x86_64-linux" "wsl";

  # Instantiates a standard NixOS machine on x86_64.
  mkLinux = mkLinuxDecorator "x86_64-linux" "nixos";

  # Instantiates a standard Apple Silicon macOS configuration.
  mkDarwin = mkDarwinDecorator "aarch64-darwin" "darwin";
in {
  # -----------------------------------------------------------------------
  # ## Library Export
  # -----------------------------------------------------------------------
  # We expose the factory under the 'flake.lib' attribute. This allows
  # our 'flake/configurations.nix' to call these functions to define
  # the actual outputs of the flake.
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
