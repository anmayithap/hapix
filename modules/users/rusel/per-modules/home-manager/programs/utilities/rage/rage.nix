{
  flake.modules.homeManager.rusel = {pkgs, ...}: {
    home.packages = with pkgs; [
      rage
    ];
  };
}
