# ----------------------------------------------------------------------------
# ## Generic Module: [Preferences > Fonts]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.fonts = {pkgs, ...}: {
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };
}
