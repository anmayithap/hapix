# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Secrets > Agenix > netrc]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-agenix = {config, ...}: {
    age = {
      secrets = {
        ".netrc" = {
          file = "${inputs.secrets}/.netrc.age";
          mode = "a+rwx,u-x,g-rwx,o-rwx";
          path = "${config.user-meta.homeDirectory}/.netrc";
          symlink = true;
        };
      };
    };
  };
}
