#: ----------------------------------------------------------------------------
#: ## [SCHEMA -> user]
#: ----------------------------------------------------------------------------
{
  den.schema.user = {lib, ...}: let
    O = lib.mkOption;
    T = lib.types;
  in {
    options = {
      git = O {
        type = T.submodule {
          options = {
            name = O {
              type = T.str;
              example = lib.literalExpression ''"John Doe"'';
              description = ''
                The name of the user.
              '';
            };
            email = O {
              type = T.str;
              example = lib.literalExpression ''"john.doe@example.com"'';
              description = ''
                The email address of the user.
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule for git user settings.
        '';
      };
    };
  };
}
