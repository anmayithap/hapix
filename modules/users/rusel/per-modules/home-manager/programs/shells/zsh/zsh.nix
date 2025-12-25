_: {
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) homeDirectory;
  in {
    programs.zsh = {
      enable = lib.mkForce true;
      autocd = lib.mkForce true;
      defaultKeymap = lib.mkForce "viins";
      dotDir = lib.mkForce "${homeDirectory}/.zshell";
      setOptions = lib.mkBefore [
        "EXTENDED_GLOB"
        "NO_NOMATCH"
        "NO_CASE_GLOB"
        "AUTO_LIST"
        "AUTO_MENU"
        "AUTO_PARAM_SLASH"
        "COMPLETE_IN_WORD"
        "INTERACTIVE_COMMENTS"
        "PROMPT_SUBST"
        "CORRECT"
      ];
      syntaxHighlighting.enable = lib.mkForce true;
    };
  };
}
