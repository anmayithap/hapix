/*
This module provides custom configurations for Zsh.
*/
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.zsh;

  baseContents = {
    ".zshenv" = ''
      # Managed by custom/zsh module
      # zshenv: loaded on all invocations of zsh.

      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
    '';

    ".zshrc" = ''
      # Managed by custom/zsh module
      # zshrc: loaded on all invocations of zsh.

      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      # => COMMON SETTINGS
      #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

      autoload -U promptinit
      promptinit

      setopt extended_glob
      setopt +o nomatch
      unsetopt CASE_GLOB
      setopt AUTO_LIST
      setopt AUTO_MENU
      setopt AUTO_PARAM_SLASH
      setopt COMPLETE_IN_WORD
      setopt INTERACTIVE_COMMENTS
      setopt PROMPT_SUBST
      setopt CORRECT

      autoload -Uz compinit
      compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS\}"
      zstyle :completion:* menu select
      zstyle ':completion:*:*:*:*:*' menu select group
      zstyle ':completion::complete:*' use-cache 1
    '';

    ".zprofile" = ''
      # Managed by custom/zsh module
      # zprofile: loaded on all invocations of zsh.
    '';
  };
in {
  options.custom.zsh = {
    enable = lib.mkEnableOption "zsh custom configuration module";

    package = lib.mkPackageOption pkgs "zsh" {};

    zdotdir = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.zshell";
      description = "Directory for zsh configuration files (ZDOTDIR).";
    };

    configFiles = lib.mkOption {
      type =
        lib.types.attrsOf
        (
          lib.types.submodule
          (
            {configFileName, ...}: {
              options = {
                fragments = lib.mkOption {
                  type = lib.types.attrsOf (
                    lib.types.submodule {
                      options = {
                        text = lib.mkOption {
                          type = lib.types.lines;
                          description = "Lines of configuration for this fragment.";
                          example = ''
                            # Managed by custom/zsh module
                            # zshenv: loaded on all invocations of zsh.
                          '';
                        };

                        order = lib.mkOption {
                          type = lib.types.int;
                          default = 500;
                          description = "Order of this fragment. Lower numbers appear earlier.";
                        };
                      };
                    }
                  );
                  default = {};
                  description = "Named configuration fragments for ${configFileName}, sorted by 'order'.";
                  example = ''
                    custom.zsh.configFiles.".zshrc".fragments."plugin" = {
                      text = \'\'source /path/to/my/plugin.zsh\'\';
                      order = 100;
                    };
                  '';
                };

                creationMethod = lib.mkOption {
                  type = lib.types.enum [
                    "symlink"
                    "direct"
                  ];
                  default = "symlink";
                  description = ''
                    How the Zsh configuration file should be managed by Home Manager:
                    - "symlink": Create the file content in the Nix store and symlink to it. (Recommended)
                    - "direct": Create the file directly with its content in the home directory.
                  '';
                };
              };
            }
          )
        );
      default = {};
      description = "Configuration content for Zsh files like .zshrc, .zshenv, etc.";
    };
  };
  config = lib.mkIf cfg.enable {
    home = {
      packages = [cfg.package];

      sessionVariables.ZDOTDIR = cfg.zdotdir;

      activation.ensureZSHdirExists = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -d "${cfg.zdotdir}" ]; then
          $DRY_RUN_CMD mkdir -p "${cfg.zdotdir}"
          $DRY_RUN_CMD echo "Created Zsh configuration directory: ${cfg.zdotdir}"
        fi
      '';

      file = let
        allRelevantFileNames = lib.unique (
          (lib.attrNames baseContents) ++ (lib.attrNames cfg.configFiles)
        );

        generatedFilesList = lib.forEach allRelevantFileNames (
          fileName: let
            userFileCfg = cfg.configFiles.${fileName} or {};
            fileOptions = {
              fragments = userFileCfg.fragments or {};
              creationMethod = userFileCfg.creationMethod or "symlink";
            };

            targetPathInHome = "${cfg.zdotdir}/${fileName}";

            userFragmentsList =
              lib.mapAttrsToList
              (name: value: value // {fragmentName = name;})
              fileOptions.fragments;

            sortedUserFragments =
              lib.sort
              (a: b: (a.order < b.order) || (a.order == b.order && a.fragmentName < b.fragmentName))
              userFragmentsList;

            baseContentForFile = baseContents.${fileName} or null;

            allContentParts =
              (lib.optional (baseContentForFile != null) baseContentForFile)
              ++ (lib.map (fragment: fragment.text) sortedUserFragments);

            fullContent = lib.concatStringsSep "\n" allContentParts;

            isExplicitlyDefinedByUser = cfg.configFiles ? ${fileName};
            shouldCreateFile = (fullContent != "") || isExplicitlyDefinedByUser;

            fileDefinition =
              if !shouldCreateFile
              then null
              else if fileOptions.creationMethod == "symlink"
              then {
                source = pkgs.writeTextFile {
                  name = "hm-managed-zsh-${lib.strings.sanitizeDerivationName fileName}";
                  text = fullContent + lib.optionalString (fullContent != "") "\n";
                };
              }
              else {
                text = fullContent + lib.optionalString (fullContent != "") "\n";
              };
          in
            if fileDefinition == null
            then null
            else {
              name = targetPathInHome;
              value = fileDefinition;
            }
        );

        finalFiles = lib.listToAttrs (lib.filter (item: item != null) generatedFilesList);
      in
        finalFiles
        // {
          "${config.home.homeDirectory}/.zshenv".text = ''
            ZDOTDIR=${cfg.zdotdir}
          '';
        };
    };
  };
}
