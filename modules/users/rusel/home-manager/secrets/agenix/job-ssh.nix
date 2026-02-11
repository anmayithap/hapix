# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Secrets > Agenix > job-ssh]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-agenix = {config, ...}: {
    age = {
      secrets = {
        "tat.ssh" = {
          file = "${inputs.secrets}/tat.ssh.age";
          mode = "a+rwx,u-x,g-rwx,o-rwx";
          path = "${config.user-meta.homeDirectory}/.ssh/tatitneft";
          symlink = true;
        };
        "tat.ssh.config" = {
          file = "${inputs.secrets}/tat.ssh.config.age";
          mode = "a+rwx,u-x,g-rwx,o-rwx";
          path = "${config.user-meta.homeDirectory}/.ssh/ssh_tatitneft_config";
          symlink = true;
        };
      };
    };
  };
}
