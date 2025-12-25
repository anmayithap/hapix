{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zellij = {
      enable = lib.mkForce true;
      settings = {
        theme = "ayu_dark";
        show_release_notes = false;
        show_startup_tips = false;
      };
    };
  };
}
