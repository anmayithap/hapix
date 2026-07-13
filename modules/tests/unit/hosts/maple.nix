#: ----------------------------------------------------------------------------
#: ## [TESTS -> unit -> hosts -> maple] Tests for maple host
#: ----------------------------------------------------------------------------
{
  self,
  den,
  ...
}: {
  flake.tests.unit-hosts-maple = {
    test-maple-declaration = {
      expr =
        (den.hosts ? aarch64-darwin)
        && (den.hosts.aarch64-darwin ? maple)
        && (den.hosts.aarch64-darwin.maple.system == "aarch64-darwin")
        && (den.hosts.aarch64-darwin.maple.class == "darwin");
      expected = true;
    };
    test-maple-definition = {
      expr =
        (self ? darwinConfigurations)
        && (self.darwinConfigurations ? maple)
        && (self.darwinConfigurations.maple.config.networking.hostName == "maple")
        && (self.darwinConfigurations.maple.config.users.users ? rusel)
        && (self.darwinConfigurations.maple.config.system.primaryUser == "rusel")
        && (self.darwinConfigurations.maple.config.system.stateVersion == 6);
      expected = true;
    };
    test-maple-darwin-firewall-preferences = let
      cfg = self.darwinConfigurations.maple.config.networking.applicationFirewall;
    in {
      expr =
        cfg.enable
        && cfg.enableStealthMode
        && cfg.blockAllIncoming
        && cfg.allowSigned
        && cfg.allowSignedApp;
      expected = true;
    };
    test-maple-darwin-networking-preferences = let
      cfg = self.darwinConfigurations.maple.config.networking;
    in {
      expr =
        cfg.computerName
        == "maple"
        && cfg.hostName == "maple"
        && cfg.localHostName == "maple"
        && cfg.domain == "home.arpa"
        && cfg.fqdn == "maple.home.arpa";
      expected = true;
    };
  };
}
