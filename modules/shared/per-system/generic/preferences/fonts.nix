# ----------------------------------------------------------------------------
# ## Fonts Preferences Module: Configures the fonts preferences
# ----------------------------------------------------------------------------
{
  flake.modules.generic.fonts = {pkgs, ...}: {
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };
}
