{inputs, ...}: {
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      config = {
        allowUnfreePredicate = _pkg: true;
      };

      overlays = [
        (
          final: _prev:
            inputs.nixpkgs-table {
              inherit (final) config;
              inherit system;
            }
        )
      ];
    };
  };
}
