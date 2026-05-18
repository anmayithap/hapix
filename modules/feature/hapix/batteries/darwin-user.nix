#: ----------------------------------------------------------------------------
#: ## [FEATURE -> hapix -> batteries -> darwin-user]
#: ----------------------------------------------------------------------------
let
  description = ''
    Defines user options specific to `nix-darwin`.

    This is because standard `den` batteries for 'nix-darwin` are not
    set some necessary parameters.

    Works only on `Darwin` systems.

    ## Usage

      den.aspects.darwin-user = {
        includes = [
          hapix.batteries.darwin-user
        ];
      };

    or globally (automatically applied depending on context):

      den.default.includes = [ hapix.batteries.darwin-user ];
  '';

  nixDarwinContext = {
    user,
    host,
  }: {
    name = "darwin-user/${user.userName}@${host.name}";

    darwin = {
      lib,
      options,
      ...
    }: let
      D = lib.mkDefault;
      If = lib.mkIf;
    in {
      users.users.${user.userName} = {
        isHidden = D false;
      };

      nix-homebrew = If (builtins.hasAttr "nix-homebrew" options) {
        user = D user.userName;
      };
    };
  };
in {
  hapix.batteries.darwin-user = {
    inherit description;

    name = "darwin-user";

    includes = [
      nixDarwinContext
    ];
  };
}
