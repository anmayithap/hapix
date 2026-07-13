{
  flake.modules.darwin.rusel-homebrew = {
    lib,
    config,
    ...
  }: {
    nix-homebrew.user = lib.mkForce config.user-meta.username;

    homebrew.caskArgs = {
      appdir = lib.mkForce "${config.user-meta.homeDirectory}/Applications";
      require_sha = lib.mkForce false;
    };
  };
}
