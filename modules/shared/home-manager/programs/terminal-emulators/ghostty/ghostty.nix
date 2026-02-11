# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Terminal Emulators > ghostty]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.ghostty = {
    lib,
    pkgs,
    ...
  }: {
    programs.ghostty = {
      enable = lib.mkDefault false;
      package = pkgs.ghostty-bin;

      # ## Don't remove default keybinds
      clearDefaultKeybinds = lib.mkDefault false;

      installVimSyntax = lib.mkDefault true;

      settings = {
        theme = lib.mkDefault "ayu";

        font-family = lib.mkDefault "JetBrainsMono Nerd Font Mono";
        font-size = lib.mkDefault 13;

        maximize = lib.mkDefault true;
        fullscreen = lib.mkDefault true;

        macos-option-as-alt = lib.mkDefault true;

        window-decoration = lib.mkDefault true;

        quit-after-last-window-closed = lib.mkDefault true;
      };
    };
  };
}
