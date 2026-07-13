#: ----------------------------------------------------------------------------
#: ## [USERS -> rusel -> environment] `environment` aspect for `rusel` namespace
#: ----------------------------------------------------------------------------
{
  rusel.environment = {
    os = {self', ...}: {
      environment.systemPackages = [
        self'.packages.hapix-environment
        self'.packages.hapix-terminal
      ];
    };
  };
}
