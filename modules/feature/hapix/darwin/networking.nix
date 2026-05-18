#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> darwin-preferences -> networking] darwin networking preset
#: ----------------------------------------------------------------------------
#: See `nix-darwin`: https://github.com/nix-darwin/nix-darwin/blob/master/modules/networking/default.nix
{hapix, ...}: {
  hapix.darwin-preferences.networking = {host, ...}: {
    includes = [
      hapix.darwin-preferences.firewall
    ];

    darwin = {lib, ...}: let
      D = lib.mkDefault;
    in {
      networking = {
        #: `scutil --set ComputerName <value>`
        #: Sets the computer name
        computerName = D host.hostName;
        #: `scutil --set HostName <value>`
        #: Sets the host name
        hostName = D host.hostName;
        #: Needs to configure `networking.fqdn` option
        domain = D "home.arpa";
      };
    };
  };
}
