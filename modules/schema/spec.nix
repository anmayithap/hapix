#: ----------------------------------------------------------------------------
#: ## [SCHEMA -> spec]
#: ----------------------------------------------------------------------------
{
  den.schema.host = {lib, ...}: let
    O = lib.mkOption;
    T = lib.types;
  in {
    options = {
      spec = O {
        type = T.submodule {
          options = {
            cores = O {
              type = T.ints.positive;
              default = 1;
              defaultText = lib.literalExpression ''1'';
              example = lib.literalExpression ''2'';
              description = ''
                The number of cores of your host machine.
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule for host machine specification.
        '';
      };
    };
  };
}
