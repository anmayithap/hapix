#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> environment] hapix environment packages
#: ----------------------------------------------------------------------------
{
  perSystem = {
    self',
    lib,
    pkgs,
    ...
  }: let
    A = lib.mkAfter;
  in {
    packages = {
      hapix-environment = self'.packages.fish.wrap {
        configFile = {
          content = A ''
            status is-interactive; and begin
              # ## source `zoxide` shell integration
              ${self'.packages.zoxide.passthru.withShell self'.packages.zoxide "fish"}
              # ## source `starship` shell integration
              ${self'.packages.starship.passthru.withShell self'.packages.starship "fish"}

              # ## Configure fzf.fish directory options
              # - `ctrl-e`: Open file in `$EDITOR`
              # - `ctrl-d`: Switch to directories fuzzy matching
              # - `ctrl-f`: Switch to files fuzzy matching
              set fzf_directory_opts "--bind=ctrl-e:execute($EDITOR {} &> /dev/tty)" \
                                     "--bind=ctrl-d:reload(fd --color=always --type d --type l --strip-cwd-prefix)" \
                                     "--bind=ctrl-f:reload(fd --color=always --type f)"

              # ## Configure fzf.fish options
              # fd options
              ${lib.optionalString (self'.packages.fd.passthru.fzfOptions != "") "set fzf_fd_opts ${self'.packages.fd.passthru.fzfOptions}"}
              # eza options
              set fzf_preview_dir_cmd eza ${self'.packages.eza.passthru.fzfOptions}

              # ## Configure preview.fish
              set fzf_preview_file_cmd preview
            end
          '';
        };

        abbreviations = {
          #: bat
          cat = "bat --paging=never";
          #: btop
          top = "btop";
          #: eza
          ls = "eza";
          ll = "eza -l";
          la = "eza -a";
          lt = "eza --tree";
          lla = "eza -la";
          #: duf
          df = "duf";
          #: dust
          du = "dust";

          argument-help = {
            regex = ''"(--help|-h)"'';
            expansion = ''"-- --help \| bat -plhelp"'';
            position = "anywhere";
          };
        };

        plugins = [
          #: Source: https://github.com/PatrickF1/fzf.fish
          {
            src = pkgs.fetchFromGitHub {
              owner = "PatrickF1";
              repo = "fzf.fish";
              tag = "v11.0";
              sha256 = "sha256-H7HgYT+okuVXo2SinrSs+hxAKCn4Q4su7oMbebKd/7s=";
            };
          }
          #: Source: https://github.com/kidonng/preview.fish
          {
            src = pkgs.fetchFromGitHub {
              owner = "kidonng";
              repo = "preview.fish";
              rev = "master";
              sha256 = "sha256-dxG9Drbmy0M5c4lCzeJ4k7BnkrJwmpI4IpkeRP6CYFk=";
            };
          }
        ];

        runtimePkgs = [
          # ## nix
          self'.packages.nh

          pkgs.timg # ## Image viewer (using by `preview.fish` plugin)
          pkgs.p7zip # ## Archives viewer (using by `preview.fish` plugin)
          pkgs.glow # ## Markdown viewer (using by `preview.fish` plugin)
          pkgs.duf
          pkgs.dust

          # ## wrapped
          self'.packages.bat
          self'.packages.btop
          self'.packages.zoxide
          self'.packages.starship
          self'.packages.fzf
          self'.packages.fd
          self'.packages.eza
        ];
      };

      hapix-terminal = self'.packages.kitty.wrap {};
    };
  };
}
