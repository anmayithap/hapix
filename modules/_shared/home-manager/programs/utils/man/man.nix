# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > man]
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.man = {
    lib,
    pkgs,
    ...
  }: {
    programs.man = {
      enable =
        if pkgs.stdenv.isDarwin
        then lib.mkForce false
        else lib.mkDefault true;
      # ## GNU `man` is not working correctly on Darwin.
      package =
        if pkgs.stdenv.isDarwin
        then lib.mkForce null
        else lib.mkDefault pkgs.man;
    };

    home.extraOutputsToInstall = lib.mkIf pkgs.stdenv.isDarwin (lib.mkAfter [
      "man"
      "info"
      "doc"
    ]);
  };
}
