{lib, ...}: {
  custom.aider = {
    enable = lib.mkDefault true;

    config = {
      model = lib.mkDefault "gemini/gemini-2.5-flash-preview-04-17";
      editor-model = lib.mkDefault "gemini/gemini-2.5-flash-preview-04-17";
      weak-model = lib.mkDefault "gemini/gemini-2.0-flash-lite-preview-02-05";

      map-tokens = lib.mkDefault 100000;
      cache-prompts = lib.mkDefault true;

      verbose = lib.mkDefault true;
      chat-language = lib.mkDefault "ru";
      dark-mode = lib.mkDefault true;
      show-diffs = lib.mkDefault true;

      edit-format = lib.mkDefault "diff";

      auto-commits = lib.mkDefault false;
      dirty-commits = lib.mkDefault false;

      auto-lint = lib.mkDefault false;
      analytics-disable = lib.mkDefault true;
      check-update = lib.mkDefault false;
      show-release-notes = lib.mkDefault false;
    };
  };
}
