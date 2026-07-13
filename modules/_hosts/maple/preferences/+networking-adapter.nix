# ----------------------------------------------------------------------------
# ## Maple Host Module: Forcing the networking host name
# ----------------------------------------------------------------------------
{
  flake.modules = {
    # ## These are generic settings that are also suitable for nixos.
    generic.maple = {lib, ...}: {
      networking = {
        hostName = lib.mkForce "maple";
      };
    };

    # ## These are settings that are only suitable for darwin.
    darwin.maple = {lib, ...}: {
      networking = {
        localHostName = lib.mkForce "maple";
        computerName = lib.mkForce "maple";
      };
    };
  };
}
