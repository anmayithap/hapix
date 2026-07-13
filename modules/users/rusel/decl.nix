#: ----------------------------------------------------------------------------
#: ## [USERS -> rusel]
#: ----------------------------------------------------------------------------
{
  inputs,
  den,
  hapix,
  rusel,
  ...
}: {
  imports = [
    (inputs.den.namespace "rusel" false)
  ];

  den.aspects.rusel = {
    includes = [
      den.batteries.primary-user # ## Marks a user as the primary user (admin level) of a host
      hapix.batteries.darwin-user # ## Sets darwin-specific user configuration
      hapix.batteries.trusted-user # ## Marks a user as trusted for nix
      hapix.hm-development # ## Provides development configuration by home-manager
      hapix.hm-firefox # ## Provides firefox configuration by home-manager
      rusel.user # ## Provides user configuration
      rusel.environment # ## Provides environment configuration
    ];
  };

  #: Declare `rusel` namespace
  rusel = {};
}
