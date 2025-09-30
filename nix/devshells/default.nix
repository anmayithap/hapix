{...}: {
  imports = [
    ./pre-commit.nix
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells = {
      default = pkgs.mkShell {
        name = "nix-config-shell";
        meta.description = "Development shell for nix-config";

        packages = config.pre-commit.settings.enabledPackages;
      };
    };
  };
}
