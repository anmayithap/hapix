#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> darwin-homebrew] darwin homebrew preset
#: ----------------------------------------------------------------------------
#: See `nix-darwin`: https://github.com/nix-darwin/nix-darwin/blob/master/modules/homebrew.nix
{inputs, ...}: {
  flake-file.inputs = {
    nix-homebrew = {
      type = "github";
      owner = "zhaofengli";
      repo = "nix-homebrew";
      ref = "main";
    };

    homebrew-core = {
      type = "github";
      owner = "homebrew";
      repo = "homebrew-core";
      ref = "main";

      flake = false;
    };

    homebrew-cask = {
      type = "github";
      owner = "homebrew";
      repo = "homebrew-cask";
      ref = "main";

      flake = false;
    };
  };

  hapix.darwin-homebrew = {
    darwin = {
      lib,
      config,
      ...
    }: let
      D = lib.mkDefault;
      B = lib.mkBefore;

      cfg = config.homebrew;
      nix-cfg = config.nix-homebrew;
    in {
      imports = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
      ];

      homebrew = {
        enable = D true;

        enableBashIntegration = D cfg.enable;
        enableFishIntegration = D cfg.enable;
        enableZshIntegration = D cfg.enable;

        onActivation = {
          cleanup = D "zap";
          upgrade = D true;
          extraFlags = B [
            "--verbose"
          ];
        };

        global = {
          brewfile = D true;
          autoUpdate = D false;
        };

        taps = D (lib.optionalAttrs nix-cfg.enable builtins.attrNames nix-cfg.taps);
      };

      nix-homebrew = {
        enable = D true;

        taps = {
          "homebrew/homebrew-core" = D inputs.homebrew-core;
          "homebrew/homebrew-cask" = D inputs.homebrew-cask;
        };

        mutableTaps = D false;
      };
    };
  };
}
