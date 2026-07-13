#: ----------------------------------------------------------------------------
#: ## [HOSTS -> maple -> preferences -> networking] networking preferences
#: ----------------------------------------------------------------------------
#: See `nix-darwin`: https://github.com/nix-darwin/nix-darwin/blob/master/modules/networking/default.nix
{
  maple.preferences.networking = {
    darwin = {lib, ...}: let
      D = lib.mkDefault;
      A = lib.mkAfter;
    in {
      networking = {
        knownNetworkServices = A [
          "Wi-Fi"
          "Thunderbolt Bridge"
        ];

        #: Clear previously configured client ID and restore
        #: the system default behavior
        dhcpClientId = D "empty";
      };
    };
  };
}
