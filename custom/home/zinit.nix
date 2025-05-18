{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.zinit;

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.zinit = {
    enable = lib.mkEnableOption "zinit custom configuration module";

    package = lib.mkPackageOption pkgs "zinit" {};

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = "${config.custom.zsh.zdotdir}/zinit";
      description = "Directory where zinit should create all working directories";
    };

    scriptsDirectory = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.homeDirectory}/zinit.git";
      description = "Directory where the zinit.zsh script and its repository will be located.";
    };

    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = ''
        List of zinit plugins definitions.
      '';
      example = ''
        [
          "zinit light zsh-users/zsh-syntax-highlighting"
        ];
      '';
    };

    snippets = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = ''
        List of zinit snippet definitions.
      '';
      example = ''
        [
          "zinit snippet OMZP::git"
        ];
      '';
    };

    postLoadCommands = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional zinit commands or Zsh script lines to execute after loading plugins and snippets.";
      example = ''
        # Bind C-g to activate fzf-history-widget if fzf is loaded
        # zinit snippet OMZ::plugins/fzf/fzf-history-widget.zsh
      '';
    };
  };

  config =
    lib.mkIf
    (cfg.enable && zshEnabled) {
      home.packages = [cfg.package];

      home.sessionVariables.ZINIT_HOME = cfg.homeDirectory;
      home.sessionVariables.ZINIT_BIN = cfg.scriptsDirectory;

      home.file."${cfg.scriptsDirectory}" = {
        source = cfg.package.src;
        recursive = true;
      };

      home.activation.ensureZinitHomeDirectoryExists = lib.hm.dag.entryAfter ["writeBoundary" "linkGeneration"] ''
        if [ ! -d "${cfg.homeDirectory}" ]; then
          $DRY_RUN_CMD mkdir -p "${cfg.homeDirectory}"
          $DRY_RUN_CMD echo "Created zinit home directory: ${cfg.homeDirectory}"
        fi
      '';

      custom.zsh.configFiles.".zshrc".fragments."zinit-loader" = {
        text = ''
          #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          # => ZINIT PLUGIN MANAGER
          #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

          source "${cfg.scriptsDirectory}/zinit.zsh"

          # Load Zinit plugins

          ${lib.concatStringsSep "\n" cfg.plugins}

          # Load Zinit snippets

          ${lib.concatStringsSep "\n" cfg.snippets}

          # Post-load commands

          ${cfg.postLoadCommands}

        '';
        order = 100;
      };
    };
}
