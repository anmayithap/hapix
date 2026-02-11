# ----------------------------------------------------------------------------
# ## Home Manager Module: Zsh Preset
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zsh = {
    lib,
    config,
    ...
  }: let
    dotDir =
      if config.xdg.enable
      then "${config.xdg.configHome}/zsh"
      else "${config.home.homeDirectory}/.zsh";

    historyDir =
      if config.xdg.enable
      then "${config.xdg.cacheHome}/zsh"
      else dotDir;
  in {
    programs.zsh = {
      enable = lib.mkDefault false;

      # ## Set zsh default keymap to `vi in insert mode"
      defaultKeymap = lib.mkDefault "viins";

      dotDir = lib.mkDefault dotDir;

      # ## Enable profiling of zsh startup
      zprof.enable = lib.mkDefault true;

      setOptions = lib.mkBefore [
        /*
        ----------------------------
        Changing Directories Options
        ----------------------------
        */

        "AUTO_CD"
        "AUTO_PUSHD"
        "PUSHD_TO_HOME"
        "CD_SILENT"
        "NO_POSIX_CD"
        "PUSHD_IGNORE_DUPS"
        "PUSHD_MINUS"
        "PUSHD_SILENT"

        /*
        ------------------
        Completion options
        ------------------
        */

        "NO_ALWAYS_LAST_PROMPT"
        "ALWAYS_TO_END"
        "AUTO_LIST"
        "AUTO_MENU"
        "AUTO_PARAM_KEYS"
        "AUTO_PARAM_SLASH"
        "AUTO_REMOVE_SLASH"
        "COMPLETE_IN_WORD"
        "HASH_LIST_ALL"
        "LIST_AMBIGUOUS"
        "NO_LIST_BEEP"
        "LIST_PACKED"
        "LIST_TYPES"

        /*
        ------------------------------
        Expansion and Globbing options
        ------------------------------
        */

        "BAD_PATTERN"
        "BARE_GLOB_QUAL"
        "CASE_MATCH"
        "EQUALS"
        "EXTENDED_GLOB"
        "GLOB"
        "GLOB_STAR_SHORT"
        "HIST_SUBST_PATTERN"
        "MAGIC_EQUAL_SUBST"
        "MARK_DIRS"
        "MULTIBYTE"
        "NOMATCH"
        "NUMERIC_GLOB_SORT"

        /*
        ---------------
        History options
        ---------------
        */

        "HIST_IGNORE_SPACE"
        "HIST_NO_STORE"
        "HIST_REDUCE_BLANKS"
        "HIST_SAVE_BY_COPY"
        "HIST_VERIFY"
        "INC_APPEND_HISTORY"
        "INC_APPEND_HISTORY_TIME"

        /*
        ----------------------
        Initialization options
        ----------------------
        */

        "GLOBAL_RCS"
        "RCS"

        /*
        --------------------
        Input/Output options
        --------------------
        */

        "ALIASES"
        "IGNORE_EOF"
        "INTERACTIVE_COMMENTS"
        "HASH_CMDS"
        "HASH_DIRS"
        "RM_STAR_WAIT"
        "SHORT_LOOPS"

        /*
        -------------------
        Job Control options
        -------------------
        */

        "AUTO_RESUME"
        "BG_NICE"
        "CHECK_JOBS"
        "CHECK_RUNNING_JOBS"
        "LONG_LIST_JOBS"
        "MONITOR"
        "NOTIFY"

        /*
        -----------------
        Prompting options
        -----------------
        */

        "PROMPT_PERCENT"
        "PROMPT_SUBST"

        /*
        -----------------------------
        ZLE (Zsh Line Editor) options
        -----------------------------
        */

        "NO_BEEP"
        "COMBINING_CHARS"
        "NO_EMACS"
        "VI"
        "ZLE"
      ];

      history = {
        path = lib.mkDefault "${historyDir}/history";

        append = lib.mkDefault true;
        share = lib.mkDefault true;

        save = lib.mkDefault 50000;
        size = lib.mkDefault 50000;

        ignoreDups = lib.mkDefault true;
        ignoreAllDups = lib.mkDefault true;
        saveNoDups = lib.mkDefault true;
        findNoDups = lib.mkDefault true;
        expireDuplicatesFirst = lib.mkDefault true;

        extended = lib.mkDefault true;

        ignorePatterns = lib.mkBefore [
          "rm*"
          "clear"
          "cd*"
          "ls*"
          "pwd"
          "exit"
          "echo*"
          "history*"
          "fc*"
          "man*"
        ];
      };
    };
  };
}
