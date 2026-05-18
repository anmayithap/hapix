#: ----------------------------------------------------------------------------
#: ## [FEATURE -> hapix -> darwin-preferences -> security] darwin security preset
#: ----------------------------------------------------------------------------
{
  hapix.darwin-preferences.security = {
    darwin = {lib, ...}: let
      D = lib.mkDefault;
    in {
      security = {
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/security/pam.nix
        pam = {
          services = {
            sudo_local = {
              enable = D true;
              touchIdAuth = D true;
              reattach = D true;
            };
          };
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/security/pki/default.nix
        pki = {
          #: Whether to enable certificate management with nix-darwin.
          installCACerts = D true;
        };
      };
    };
  };
}
