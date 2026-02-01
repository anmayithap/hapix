# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Forcing the networking host name
# ----------------------------------------------------------------------------
{
  flake.modules = {
    generic.maple = {lib, ...}: {
      networking = {
        hostName = lib.mkForce "maple";
      };
    };

    darwin.maple = {lib, ...}: {
      networking = {
        localHostName = lib.mkForce "maple";
        computerName = lib.mkForce "maple";
      };
    };
  };
}
