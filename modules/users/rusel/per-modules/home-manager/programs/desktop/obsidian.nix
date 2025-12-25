{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    unfree = with pkgs; [obsidian];

    programs.obsidian = {
      enable = lib.mkForce true;
    };
  };
}
