{
  flake.modules.darwin.rusel-user = {
    lib,
    config,
    ...
  }: {
    users.users.${config.user-meta.username} = {
      isHidden = lib.mkForce false;

      # ## 501 is the default UID for first darwin user
      uid = lib.mkForce 501;
    };
  };
}
