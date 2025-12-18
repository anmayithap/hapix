{inputs, ...}: let
  system-packages = {pkgs, ...}: {
    environment.systemPackages = with inputs.nix-darwin.packages.${pkgs.system}; [
      darwin-option
      darwin-rebuild
      darwin-version
      darwin-uninstaller
    ];
  };
in {
  flake.modules.darwin = {inherit system-packages;};
}
