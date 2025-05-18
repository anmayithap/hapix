{lib, ...}: {
  custom.aider = {
    enable = lib.mkDefault true;

    config = {
      model = lib.mkDefault "openrouter/qwen/qwen3-235b-a22b:free";
      weak-model = lib.mkDefault "openrouter/qwen/qwen3-235b-a22b:free";
      map-tokens = lib.mkDefault 1024;
      verbose = lib.mkDefault true;
      chat-language = lib.mkDefault "ru";
      cache-prompts = lib.mkDefault false;
      dark-mode = lib.mkDefault true;
      show-diffs = lib.mkDefault true;
      auto-commits = lib.mkDefault false;
      dirty-commits = lib.mkDefault false;
      auto-lint = lib.mkDefault false;
      analytics-disable = lib.mkDefault true;
      check-update = lib.mkDefault false;
      show-release-notes = lib.mkDefault false;
    };
  };
}
