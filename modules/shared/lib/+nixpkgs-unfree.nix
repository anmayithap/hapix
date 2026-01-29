# ----------------------------------------------------------------------------
# ## Nixpkgs Unfree Configuration
# ----------------------------------------------------------------------------
# This module defines a Nixpkgs option that allows to specify a list of
# packages that are allowed to be built with the `nixpkgs.config.allowUnfreePredicate`
# predicate function.
#
# Note: Since this lib module defines the description of options,
# it is necessary to initialize the attribute set. For example:
#
# ```nix
# flake.modules.generic.nixpkgs-unfree = inputs.self.lib.nixpkgs-unfree;
# ```
{
  flake.lib.unfree = {
    lib,
    config,
    ...
  }: let
    inherit (lib.types) listOf package;
  in {
    options.unfree = lib.mkOption {
      type = listOf package;

      default = [];
      defaultText = ''[]'';

      description = ''
        List of `nixpkgs` packages to which the predicate function
        from `nixpkgs.config.allowUnfreePredicate` applies.
      '';
    };

    config.nixpkgs.config.allowUnfreePredicate = pkg: let
      pkgName = lib.getName pkg;

      allowedNames = map lib.getName config.unfree;
    in
      lib.elem pkgName allowedNames;
  };
}
