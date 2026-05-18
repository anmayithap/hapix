#: ----------------------------------------------------------------------------
#: ## [FEATURE -> hapix -> batteries -> trusted-user]
#: ----------------------------------------------------------------------------
let
  description = ''
    Define the user as trusted for nix.

    According to the option `nix.settings.trusted-users` the user defined
    in these aspect will be able to connect to the Nix daemon.

    ## Usage

      den.aspects.user = {
        includes = [
          hapix.batteries.trusted-user
        ];
      };

    or globally (automatically applied depending on context):

      den.default.includes = [ hapix.batteries.trusted-user ];
  '';

  userContext = {
    user,
    host,
  }: {
    name = "trusted-user/${user.userName}@${host.name}";

    os = {lib, ...}: let
      A = lib.mkAfter;
    in {
      nix.settings = {
        trusted-users = A [
          user.userName
        ];
      };
    };
  };
in {
  hapix.batteries.trusted-user = {
    inherit description;

    name = "trusted-user";

    includes = [
      userContext
    ];
  };
}
