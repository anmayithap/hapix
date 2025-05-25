{lib, ...}: {
  custom.zellij = {
    enable = lib.mkDefault true;

    settings = {
      theme = "ayu_dark";
      show_release_notes = false;
      show_startup_tips = false;
    };
  };
}
