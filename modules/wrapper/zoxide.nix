# -----------------------------------------------------------------------------
# ## [WRAPPER -> zoxide] smaller cd command, inspired by z and autojump
# -----------------------------------------------------------------------------
#: Source: https://github.com/ajeetdsouza/zoxide
#: Documentation: https://github.com/ajeetdsouza/zoxide#configuration
#: Changelog: https://github.com/ajeetdsouza/zoxide/blob/main/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      zoxide = D true; # ## Exclude being built into `packages.*.*` flake output
    };
  };

  flake.wrappers.zoxide = {
    wlib,
    lib,
    pkgs,
    config,
    ...
  }: let
    D = lib.mkDefault;
    O = lib.mkOption;
  in {
    imports = [wlib.modules.default];

    options = {
      zoxide = O {
        type = lib.types.submodule {
          options = {
            cmd = O {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = ''
                Changes the prefix of the `z` and `zi` commands.

                For example, `--cmd j` will change the commands to `j` and `ji` respectively.

                Setting `--cmd cd` will replace the `cd` command, but is not supported in
                NuShell and POSIX shells.

                See <https://github.com/ajeetdsouza/zoxide#flags>.
              '';
              example = lib.literalExpression "j";
            };
            hook = O {
              type = lib.types.enum ["none" "prompt" "pwd"];
              default = "pwd";
              description = ''
                Configures when zoxide increments a directory's score.

                - `none`:   Never
                - `prompt`: On every prompt
                - `pwd`:    Whenever the directory is changed (default)

                See <https://github.com/ajeetdsouza/zoxide#flags>.
              '';
            };
            noCmd = O {
              type = lib.types.bool;
              default = false;
              description = ''
                Prevents zoxide from defining the `z` and `zi` commands.

                The functions `__zoxide_z` and `__zoxide_zi` are still available for manual redefinition.

                See <https://github.com/ajeetdsouza/zoxide/blob/main/README.md#flags>.
              '';
            };
            dataDir = O {
              type = lib.types.nullOr lib.types.str;
              default = null;
              example = "/home/user/.local/share/zoxide";
              description = ''
                Specifies the directory in which the database is stored.

                The default value is platform-specific:
                - Linux:    `$XDG_DATA_HOME/zoxide` or `~/.local/share/zoxide`
                - macOS:    `~/Library/Application Support/zoxide`

                See <https://github.com/ajeetdsouza/zoxide#environment-variables>.
              '';
            };
            echo = O {
              type = lib.types.bool;
              default = false;
              description = ''
                When set to `true`, zoxide will print the matched directory before navigating to it.

                See <https://github.com/ajeetdsouza/zoxide#environment-variables>.
              '';
            };
            excludeDirs = O {
              type = lib.types.listOf lib.types.str;
              default = [];
              example = [
                "/tmp"
                "/var"
                "$HOME/private/*"
              ];
              description = ''
                Prevents the specified directories from being added to the database.

                Glob patterns are supported. The separator is platform-specific:
                - Linux/macOS:  `:`

                By default, `$HOME` is excluded.

                See <https://github.com/ajeetdsouza/zoxide#environment-variables>.
              '';
            };
            fzfOpts = O {
              type = lib.types.listOf lib.types.str;
              default = [];
              example = [
                "--height=40%"
                "--reverse"
              ];
              description = ''
                Specifies additional options to pass to `fzf` during interactive selection (`zi`).

                See `man fzf` for the full list of options.

                See <https://github.com/ajeetdsouza/zoxide#environment-variables>.
              '';
            };
            maxAge = O {
              type = lib.types.nullOr lib.types.ints.positive;
              default = null;
              example = 5000;
              description = ''
                Configures the maximum total age before zoxide removes directories from the database.

                The default value is `10000`.

                See <https://github.com/ajeetdsouza/zoxide#environment-variables>.
              '';
            };
            resolveSymlinks = O {
              type = lib.types.bool;
              default = false;
              description = ''
                When set to `true`, zoxide will resolve symlinks before adding directories to the database.

                See <https://github.com/ajeetdsouza/zoxide#environment-variables>.
              '';
            };
            initFlags = O {
              type = lib.types.str;
              default = lib.concatStringsSep " " (lib.filter (value: value != "") [
                (lib.optionalString (config.zoxide.cmd != null) "--cmd ${lib.escapeShellArg config.zoxide.cmd}")
                "--hook ${lib.escapeShellArg config.zoxide.hook}"
                (lib.optionalString config.zoxide.noCmd "--no-cmd")
              ]);
              description = ''
                Computed command-line flags passed to `zoxide init`.
                Derived from `cmd`, `hook` and `noCmd` options.
                Cannot be set directly; configure those options instead.
              '';
              readOnly = true;
            };
          };
        };
        default = {};
        description = ''
          Configuration options for zoxide, a smarter cd command.

          See <https://github.com/ajeetdsouza/zoxide#configuration>.
        '';
      };
    };

    config = {
      package = D pkgs.zoxide;

      #: Pure attribute set of all _ZO_* environment variables
      #: Filtered to remove nulls so unset options do not pollute the environment
      env = lib.filterAttrs (_: value: value != null) {
        _ZO_DATA_DIR = {
          data = config.zoxide.dataDir;
          esc-fn = config.escapingFunction;
        };
        _ZO_ECHO = {
          data =
            if config.zoxide.echo
            then "1"
            else null;
          esc-fn = config.escapingFunction;
        };
        _ZO_EXCLUDE_DIRS = {
          data =
            if config.zoxide.excludeDirs != []
            then lib.concatStringsSep ":" config.zoxide.excludeDirs
            else null;
          esc-fn = config.escapingFunction;
        };
        _ZO_FZF_OPTS = {
          data =
            if config.zoxide.fzfOpts != []
            then lib.concatStringsSep " " config.zoxide.fzfOpts
            else null;
          esc-fn = config.escapingFunction;
        };
        _ZO_MAXAGE = {
          data =
            if config.zoxide.maxAge != null
            then toString config.zoxide.maxAge
            else null;
          esc-fn = config.escapingFunction;
        };
        _ZO_RESOLVE_SYMLINKS = {
          data =
            if config.zoxide.resolveSymlinks
            then "1"
            else null;
          esc-fn = config.escapingFunction;
        };
      };

      passthru = {
        inherit (config.zoxide) initFlags;

        withShell = self: shell: let
          bin = lib.getExe self;
        in
          if shell == "fish"
          then "${bin} init ${shell} ${config.zoxide.initFlags} | source"
          else if shell == "bash" || shell == "zsh"
          then "eval \"$(${bin} init ${shell})\""
          else throw "shell ${shell} is not supported yet";
      };
    };
  };
}
