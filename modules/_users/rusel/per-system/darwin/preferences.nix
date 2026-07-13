{
  flake.modules.darwin.rusel-preferences = {
    lib,
    config,
    ...
  }: {
    system = {
      primaryUser = lib.mkForce config.user-meta.username;

      defaults = {
        dock = {
          persistent-others = lib.mkAfter [
            "${config.user-meta.homeDirectory}/dev"
            "${config.user-meta.homeDirectory}/Downloads"
          ];
        };

        screencapture = {
          target = lib.mkForce "clipboard";
          location = lib.mkForce "${config.user-meta.homeDirectory}/Pictures/screenshots";
        };
      };
    };
  };
}
