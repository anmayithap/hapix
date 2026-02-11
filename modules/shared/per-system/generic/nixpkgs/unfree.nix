# ----------------------------------------------------------------------------
# ## Generic Module: [Nixpkgs > Unfree]
# ----------------------------------------------------------------------------
# Allows the following structure to be used within configurations:
#
# ```nix
# unfree = with pkgs; [
#   <package>
# ]
# ```
{inputs, ...}: {
  flake.modules.generic.unfree = inputs.self.lib.unfree;
}
