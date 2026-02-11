# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Secrets > Agenix > dotenv]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-agenix = {config, ...}: {
    age = {
      secrets = {
        ".env" = {
          file = "${inputs.secrets}/.env.age";
          mode = "a+rwx,u-wx,g-wx,o-wx";
          path = "${config.user-meta.homeDirectory}/.env";
          symlink = true;
        };
      };
    };
  };
}
