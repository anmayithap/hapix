# ----------------------------------------------------------------------------
# ## Maple Host Module: [Security > SSH] Add SSH private key
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple = {
    lib,
    config,
    ...
  }: {
    age = {
      secrets = {
        "maple.ssh" = {
          file = lib.mkForce "${inputs.secrets}/maple.ssh.age";
          mode = lib.mkForce "a+rwx,u-wx,g-wx,o-wx";
          path = lib.mkForce "${config.user-meta.homeDirectory}/.ssh/maple";
          symlink = lib.mkForce true;
        };
      };
    };
  };
}
