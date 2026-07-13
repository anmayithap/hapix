{
  flake.modules.generic.rusel-preferences = {
    lib,
    config,
    ...
  }: {
    nix.settings = {
      trusted-users = lib.mkAfter [
        config.user-meta.username
      ];
      allowed-users = lib.mkAfter [
        config.user-meta.username
      ];
    };
  };
}
