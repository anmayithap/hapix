{
  flake.modules.darwin.rusel = {lib, ...}: {
    networking.dns = lib.mkAfter ["127.0.0.1"];

    launchd.daemons.dnscrypt-proxy.serviceConfig = {
      UserName = lib.mkForce "root";
      GroupName = lib.mkForce "wheel";
    };

    system.activationScripts.postActivation.text = ''
      sudo killall -HUP mDNSResponder || true
    '';
  };
}
