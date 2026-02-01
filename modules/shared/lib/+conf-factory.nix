# ----------------------------------------------------------------------------
# ## System Configuration Factory
# ----------------------------------------------------------------------------
# This module defines attribute sets, which contains presets and decorators
# for system assemblies.
{inputs, ...}: let
  /*
  ---------------------------------------------------------------------------
  getMod: Extract the attribute set of the module
  ---------------------------------------------------------------------------

  Arguments:
    path: Path to the module
    name: Name of the module

  Returns:
    The attribute set of the module
  */
  getMod = path: name: path.${name} or {};

  /*
  ---------------------------------------------------------------------------
  mkSystem: Create a system configuration
  ---------------------------------------------------------------------------

  Arguments:
    builder: System builder function (nixosSystem, darwinSystem, etc.)
    system: System architecture (x86_64-linux, aarch64-darwin, etc.)
    class: Module class (nixos, darwin, generic, etc.)
    name: Host name

  Returns:
    The system configuration
  */
  mkSystem = builder: system: class: name:
    builder {
      inherit system;

      modules = [
        (getMod inputs.self.modules.generic name)
        (getMod inputs.self.modules.${class} class)
        (getMod inputs.self.modules.${class} name)
      ];
    };

  decorators = {
    /*
    ---------------------------------------------------------------------------
    mkLinux: Create a Linux system configuration
    ---------------------------------------------------------------------------

    Arguments:
      system: System architecture
      class: Module class
      name: Host name

    Returns:
      The system configuration
    */
    mkLinux = mkSystem inputs.nixpkgs.lib.nixosSystem;
    /*
    ---------------------------------------------------------------------------
    mkDarwin: Create a Darwin system configuration
    ---------------------------------------------------------------------------

    Arguments:
      system: System architecture
      class: Module class
      name: Host name

    Returns:
      The system configuration
    */
    mkDarwin = mkSystem inputs.nix-darwin.lib.darwinSystem;
  };

  presets = {
    /*
    ---------------------------------------------------------------------------
    mkLinuxWSLX86: Create a Linux WSL system configuration on x86_64-linux
    ---------------------------------------------------------------------------

    Arguments:
      name: Host name

    Returns:
      The system configuration
    */
    mkLinuxWSLX86 = decorators.mkLinux "x86_64-linux" "wsl";
    /*
    ---------------------------------------------------------------------------
    mkLinuxX86: Create a Linux system configuration on x86_64-linux
    ---------------------------------------------------------------------------

    Arguments:
      name: Host name

    Returns:
      The system configuration
    */
    mkLinuxX86 = decorators.mkLinux "x86_64-linux" "nixos";
    /*
    ---------------------------------------------------------------------------
    mkDarwinSilicon: Create a Darwin system configuration on aarch64-darwin
    ---------------------------------------------------------------------------

    Arguments:
      name: Host name

    Returns:
      The system configuration
    */
    mkDarwinSilicon = decorators.mkDarwin "aarch64-darwin" "darwin";
  };
in {
  flake.lib.confFactory = {
    inherit presets;
    inherit decorators;
  };
}
