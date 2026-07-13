#: ----------------------------------------------------------------------------
#: ## [FLAKE -> dendritic] some dendritic libraries | frameworks
#: ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    inputs.den.flakeModules.default
  ];

  flake-file = {
    inputs = {
      #: Source: https://github.com/vic/den
      #: Documentation: https://den.oeiuwq.com/
      den = {
        type = "github";
        owner = "vic";
        repo = "den";
        ref = "latest";
      };
    };
  };
}
