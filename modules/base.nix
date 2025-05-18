{profile, ...}: {
  imports = [
    ./shared
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];

    trusted-users = [profile.username];

    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
