{lib, ...}: {
  custom.zellij = {
    enable = lib.mkDefault true;

    attachExistingSession = lib.mkDefault true;
    exitShellOnExit = lib.mkDefault false;

    settings = {
      theme = "ayu_dark";
      show_release_notes = false;
      show_startup_tips = false;
    };
  };
}
