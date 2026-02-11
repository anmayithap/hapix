# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Security > SSH]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-ssh = {
    lib,
    osConfig,
    ...
  }: {
    programs.ssh = {
      enable = lib.mkForce true;

      matchBlocks = {
        "github.com" = {
          hostname = "ssh.github.com";
          port = 443;
          user = "git";

          identityFile = osConfig.age.secrets."maple.ssh".path;
          identitiesOnly = true;
        };

        "vpn" = {
          hostname = "5.129.233.150";
          user = "rusel";
        };
      };
    };
  };
}
