#: ----------------------------------------------------------------------------
#: ## [DEFAULTS -> generic] default settings for all aspects
#: ----------------------------------------------------------------------------
{den, ...}: {
  den.default.includes = [
    den.batteries.define-user # ## Creates os-level user accounts
    den.batteries.hostname # ## Automatically sets the host's name
    den.batteries.inputs'
    den.batteries.self'
  ];

  den.default = {
    os = {lib, ...}: let
      D = lib.mkDefault;
    in {
      time.timeZone = D "Europe/Moscow";

      environment = {
        #: Whether to install all terminfo outputs.
        enableAllTerminfo = D false;
      };

      security = {
        #: Whether to preserve `TERMINFO` and `TERMINFO_DIRS` environment variables,
        #: for `root` and the `admin` group.
        sudo.keepTerminfo = D true;
      };
    };
  };
}
