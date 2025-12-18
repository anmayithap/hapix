_: {
  flake.modules.darwin.nix-settings.nix.settings = {lib, ...}: {
    trusted-users = lib.mkAfter [
      "rusel"
    ];
    allowed-users = lib.mkAfter [
      "rusel"
    ];
  };
}
