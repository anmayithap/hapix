# ----------------------------------------------------------------------------
# ## Maple Host Module: [Security > VPN] Add VPN configurations
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple = {
    lib,
    config,
    ...
  }: let
    mkVPNPath = class: filename: "${config.user-meta.homeDirectory}/.config/vpn/${class}/${filename}";
    mkOVPNPath = mkVPNPath "ovpn";
  in {
    age = {
      secrets = {
        "tat.ovpn" = {
          file = lib.mkForce "${inputs.secrets}/tat.ovpn.age";
          mode = lib.mkForce "a+rwx,u-wx,g-wx,o-wx";
          path = lib.mkForce (mkOVPNPath "tat.ovpn");
          symlink = lib.mkForce true;
        };
        "tat.ovpn.auth" = {
          file = lib.mkForce "${inputs.secrets}/tat.ovpn.auth.age";
          mode = lib.mkForce "a+rwx,u-wx,g-wx,o-wx";
          path = lib.mkForce (mkOVPNPath "tat.ovpn.auth.txt");
          symlink = lib.mkForce true;
        };
        "maple.ovpn" = {
          file = lib.mkForce "${inputs.secrets}/maple.ovpn.age";
          mode = lib.mkForce "a+rwx,u-wx,g-wx,o-wx";
          path = lib.mkForce (mkOVPNPath "maple.ovpn");
          symlink = lib.mkForce true;
        };
      };
    };
  };
}
