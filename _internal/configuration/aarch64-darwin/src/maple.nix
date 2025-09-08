{
  lib,
  profile,
  common-tools,
  validation-tools,
  genSpecialArgs,
  system,
  darwinFactory,
  ...
}@args: let
  modules = {
    darwin-modules =
        (map common-tools.relativeToRoot [
          "apps-patch.nix"
        ]);
  };

  systemArgs = modules // args;
in
{
  inherit systemArgs;
  darwinConfigurations.${profile.hostname} = darwinFactory systemArgs;
}
