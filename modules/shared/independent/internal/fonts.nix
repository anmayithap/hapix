_: let
  fonts = {pkgs, ...}: {
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };
in {
  flake.modules.darwin = {inherit fonts;};
  flake.modules.nixos = {inherit fonts;};
}
