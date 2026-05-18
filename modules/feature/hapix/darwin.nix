#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> darwin] darwin support and base definitions
#: ----------------------------------------------------------------------------
{hapix, ...}: {
  flake-file.inputs = {
    darwin = {
      type = "github";
      owner = "LnL7";
      repo = "nix-darwin";
      ref = "master";
    };
  };

  hapix.darwin = {
    includes = [
      hapix.darwin-preferences
      hapix.darwin-homebrew
    ];
  };
}
