{flake-parts-lib, ...}: let
  inherit (flake-parts-lib) importApply;

  aarch64-darwin = importApply ./aarch64-darwin;
in {
  imports = [
    ./x86_64-linux
    ./aarch64-darwin
  ];
}
