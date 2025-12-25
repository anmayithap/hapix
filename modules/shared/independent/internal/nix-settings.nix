let
  nix-settings = _: {
    nix = {
      optimise.automatic = true;

      settings = {
        substituters = [
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        allowed-users = [
          "root"
        ];
      };

      gc = {
        automatic = true;
        interval = [
          {
            Hour = 8;
            Minute = 30;
          }
        ];
      };
    };
  };
in {
  flake.modules.darwin = {inherit nix-settings;};
  flake.modules.nixos = {inherit nix-settings;};
}
