# ----------------------------------------------------------------------------
# ## Home Manager Module: Configures home-manager
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.homeManager = {lib, ...}: {
    home-manager = {
      backupFileExtension = lib.mkDefault "home-manager.bak";
      # We use our own pkgs home-manager, as we configure overlays
      # within it separately from the system pkgs.
      useGlobalPkgs = lib.mkDefault false;
      useUserPackages = lib.mkDefault true;
      verbose = lib.mkDefault true;

      ## Modules that apply to all users
      sharedModules = lib.mkBefore [
        # ## Modules
        # See: `modules/shared/per-system/generic/home-manager/home.nix`
        inputs.self.modules.homeManager.home
        # See: `modules/shared/home-manager/secrets/as-module.nix`
        inputs.self.modules.homeManager.secrets
        # See: `modules/shared/home-manager/programs/as-module.nix`
        inputs.self.modules.homeManager.programs
        # See: `modules/shared/per-system/generic/nixpkgs/unfree.nix`
        inputs.self.modules.generic.unfree

        # ## Overlays
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/nur.nix`
        inputs.self.modules.generic.nur-overlay
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/vscode-extensions.nix`
        inputs.self.modules.generic.vscode-extensions-overlay
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/stable.nix`
        inputs.self.modules.generic.stable-overlay
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/dnscrypt.nix`
        inputs.self.modules.generic.dnscrypt-overlay
      ];
    };
  };
}
