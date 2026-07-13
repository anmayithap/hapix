#: ----------------------------------------------------------------------------
#: ## [FLAKE -> flake] flake configuration
#: ----------------------------------------------------------------------------
{
  inputs,
  lib,
  ...
}: let
  D = lib.mkDefault;
  A = lib.mkAfter;
in {
  imports = [
    inputs.flake-file.flakeModules.flakeless-parts
  ];

  flake-file = {
    description = D "Anmayithap's unified NixOS and MacOS configuration";

    inputs = {
      hapix = {
        type = "github";
        owner = "anmayithap";
        repo = "hapix";
        ref = "master";

        flake = false;
      };
      #: Source: https://github.com/NixOS/nixpkgs
      #: Status: https://status.nixos.org
      nixpkgs = {
        type = "github";
        owner = "NixOS";
        repo = "nixpkgs";
        ref = "nixpkgs-unstable";
      };
      #: Source: https://github.com/vic/flake-file
      #: Documentation: https://flake-file.oeiuwq.com
      flake-file = {
        type = "github";
        owner = "vic";
        repo = "flake-file";
        ref = "latest";
      };
      #: Source: https://github.com/vic/import-tree
      #: Documentation: https://import-tree.oeiuwq.com
      import-tree = {
        type = "github";
        owner = "vic";
        repo = "import-tree";
        ref = "latest";
      };
      #: Source: https://github.com/vic/with-inputs
      with-inputs = {
        type = "github";
        owner = "vic";
        repo = "with-inputs";
        ref = "latest";

        flake = false;
      };
    };

    nixConfig = {
      extra-substituters = A [
        #: Cache mirror located in China
        #: Status: https://mirrors.ustc.edu.cn/status/
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # status: https://mirror.sjtu.edu.cn/
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
        # others
        # "https://mirrors.sustech.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://nix-community.cachix.org"
        "https://cache.numtide.com"
        "https://cache.dos.cit.tum.de"
      ];
      extra-trusted-public-keys = A [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "cache.dos.cit.tum.de-1:ZCSRbf/HsV0XwrrfR4dC6HyrjqwqKXmR/hDPsYyZ9Sg="
      ];
    };
  };
}
