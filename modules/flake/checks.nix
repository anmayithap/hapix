#: ----------------------------------------------------------------------------
#: ## [FLAKE -> checks] configure flake checks
#: ----------------------------------------------------------------------------
{
  perSystem = {
    devshells.default.commands = [
      {
        name = "flake-check";
        help = "Run flake checks";
        category = "flake";
        command = ''nix flake check "$@"'';
      }
    ];
  };
}
