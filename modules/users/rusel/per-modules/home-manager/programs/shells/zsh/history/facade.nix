_: {
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh = {
      setOptions = lib.mkBefore [
        "INC_APPEND_HISTORY"
        "HIST_REDUCE_BLANKS"
      ];
    };
  };
}
