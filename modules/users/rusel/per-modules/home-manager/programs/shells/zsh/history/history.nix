_: {
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: {
    programs.zsh.history = {
      append = lib.mkForce true;
      expireDuplicatesFirst = lib.mkForce true;
      extended = lib.mkForce true;
      findNoDups = lib.mkForce true;
      ignoreAllDups = lib.mkForce true;
      ignoreDups = lib.mkForce true;
      ignorePatterns = lib.mkBefore [
        "rm *"
      ];
      path = lib.mkForce "${config.programs.zsh.dotDir}/.histfile";
      save = lib.mkForce 50000;
      saveNoDups = lib.mkForce true;
      share = lib.mkForce true;
      size = lib.mkForce 50000;
    };
  };
}
