{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.eza = {
      enable = lib.mkForce true;
      colors = lib.mkForce "always";
      extraOptions = lib.mkBefore [
        "-A"
        "-F"
        "--group-directories-first"
        "--sort=extension"
      ];
      icons = lib.mkForce "auto";
      git = lib.mkForce true;
    };
  };
}
