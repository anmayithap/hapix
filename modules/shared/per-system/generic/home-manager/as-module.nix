# ----------------------------------------------------------------------------
# ## Generic Module: [Home Manager]
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
        # ## NVF (Nix Vim Flake)
        inputs.nvf.homeManagerModules.default
        # ## Nix Index Database
        inputs.nix-index-database.homeModules.nix-index
        # ## Agenix
        inputs.agenix.homeManagerModules.default

        # See: `modules/shared/per-system/generic/home-manager/home.nix`
        inputs.self.modules.homeManager.home
        # See: `modules/shared/home-manager/programs/as-module.nix`
        inputs.self.modules.homeManager.programs
        # See: `modules/shared/home-manager/xdg/as-module.nix`
        inputs.self.modules.homeManager.xdg
        # See: `modules/shared/home-manager/user.nix`
        inputs.self.modules.homeManager.user
        # See: `modules/shared/home-manager/services/containerization/as-module.nix`
        inputs.self.modules.homeManager.containerization
        # See: `modules/shared/home-manager/services/keyboard/as-module.nix`
        inputs.self.modules.homeManager.keyboard
        # See: `modules/shared/home-manager/services/secrets/as-module.nix`
        inputs.self.modules.homeManager.secrets
        # See: `modules/shared/per-system/generic/nixpkgs/unfree.nix`
        inputs.self.modules.generic.unfree

        # ## Overlays
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/nur.nix`
        inputs.self.modules.generic.nur-overlay
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/vscode-extensions.nix`
        inputs.self.modules.generic.vscode-extensions-overlay
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/lts.nix`
        inputs.self.modules.generic.lts-overlay
        # See: `modules/shared/per-system/generic/nixpkgs/overlays/dnscrypt.nix`
        inputs.self.modules.generic.dnscrypt-overlay
      ];
    };
  };
}
