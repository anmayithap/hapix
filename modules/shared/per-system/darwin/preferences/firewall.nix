# ----------------------------------------------------------------------------
# ## Darwin Module: [Preferences > Firewall]
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.firewall = {lib, ...}: {
    # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-networking.applicationFirewall.enable
    networking.applicationFirewall.enable = lib.mkDefault true;
  };
}
