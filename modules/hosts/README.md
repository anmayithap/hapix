# 📂 [MODULES] / HOSTS

## System-Specific Identities and Machine Configurations

This directory contains the unique definitions for every machine (host) managed by this flake.
It serves as the final assembly point where reusable profiles, hardware-specific settings,
and network identities are combined into a bootable system configuration.

## ARCHITECTURE OVERVIEW

Each subdirectory represents a single machine, identified by its `hostname`.
These modules are typically registered in the flake's internal module registry,
allowing the configuration factory to instantiate them dynamically.

## HOW TO ADD A NEW HOST

1. Create a directory under `modules/hosts/<hostname>`.
2. Define a **configuration.nix**:

   ```nix
   { inputs, ... }: {
   flake.modules.<class>.<hostname>.imports = [
       inputs.self.modules.<class>.<username>
       { networking.hostName = "<hostname>"; }
   ];
   }
   ```

3. Register the host in `flake/configurations.nix` using the factory helpers (mkDarwin, mkLinux or mkLinuxWSL).
