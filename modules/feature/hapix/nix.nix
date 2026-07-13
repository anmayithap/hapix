#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> nix] nix preset
#: ----------------------------------------------------------------------------
{
  hapix.nix = {
    os = {
      lib,
      pkgs,
      ...
    }: let
      D = lib.mkDefault;
      A = lib.mkAfter;
      B = lib.mkBefore;
    in {
      nix = {
        channel.enable = D false;
        nixPath = A [
          "nixpkgs=${pkgs.path}"
        ];

        settings = {
          substituters = B [
            "https://hapix.cachix.org"
          ];

          trusted-public-keys = B [
            "hapix.cachix.org-1:SieJ8e4NGjdEp/KL6+Oze6ZZcsWFFxW5cP8LFC9kWZc="
          ];
        };

        extraOptions = A ''
          abort-on-warn                 = true        # ## builtins.warn will throw an error when logging a warning
          allow-dirty                   = true        # ## Whether to allow dirty git trees
          allow-import-from-derivation  = true
          connect-timeout               = 5           # ## 300 seconds timeout to binary cache substituter
          min-free                      = 128000000   # ## 128 MB
          max-free                      = 1000000000  # ## 1 GB
          fallback                      = true        # ## Building from source if a binary substitute fails
          warn-dirty                    = false
          experimental-features         = nix-command flakes
        '';
      };
    };
  };
}
