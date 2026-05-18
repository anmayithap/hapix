#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> darwin-preferences -> firewall] darwin firewall preset
#: ----------------------------------------------------------------------------
#: See `nix-darwin`: https://github.com/nix-darwin/nix-darwin/blob/master/modules/networking/applicationFirewall.nix
#: See `developer.apple.com`: https://developer.apple.com/documentation/devicemanagement/firewall
#:
#: Note: From a security point of view, it is best to disable the `allowSigned` and `allowSignedApp` parameters.
{
  hapix.darwin-preferences.firewall = {
    darwin = {lib, ...}: let
      D = lib.mkDefault;
    in {
      networking.applicationFirewall = {
        #: `socketfilterfw --setglobalstate <value>`
        #: Enabling the firewall
        enable = D true;
        #: `socketfilterfw --setstealthmode <value>`
        #: Enabling stealth mode
        enableStealthMode = D true;
        #: `socketfilterfw --setblockall <value>`
        #: Blocking all incoming connections
        blockAllIncoming = D true;
        #: `socketfilterfw --setallowsigned <value>`
        #: Allow receive incoming connections for built-in software
        allowSigned = D true;
        #: `socketfilterfw --setallowsignedapp <value>`
        #: Allow receive incoming connection for downloaded signed software
        allowSignedApp = D true;
      };
    };
  };
}
