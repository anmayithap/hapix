#: ----------------------------------------------------------------------------
#: ## [USERS -> rusel -> user] `user` aspect for `rusel` namespace
#: ----------------------------------------------------------------------------
{lib, ...}: let
  F = lib.mkForce;
in {
  rusel.user = {
    #: general user settings (system-agnostic)
    user = {
      description = "Ruslan Torbeev";
      createHome = F true;
    };

    #: nix-darwin user specific settings
    darwin.users.users.rusel = {
      uid = F 501; # ## By default, the first Darwin user has UID 501
    };
  };
}
