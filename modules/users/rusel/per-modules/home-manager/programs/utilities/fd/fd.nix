{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.fd = {
      enable = lib.mkForce true;
      extraOptions = lib.mkBefore [
        "--strip-cwd-prefix"
        "--follow"
        "--exclude .git"
      ];
      hidden = lib.mkForce true;
    };
  };
}
