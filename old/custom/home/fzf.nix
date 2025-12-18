{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.fzf;

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.fzf = {
    enable = lib.mkEnableOption "fzf custom configuration module";

    package = lib.mkPackageOption pkgs "fzf" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    custom.zsh.configFiles.".zshrc".fragments."fzf-options" = lib.mkIf zshEnabled {
      text = ''
        # fzf options (managed by custom/fzf module)

        zstyle ':fzf-tab:complete:(\\|)git:*' fzf-preview 'git diff $word | delta || git diff $word'
        zstyle ':fzf-tab:complete:(\\|)systemctl:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
        zstyle ':fzf-tab:complete:(\\|)docker:*' fzf-preview 'docker ps --filter \"name=$word\"'
        zstyle ':fzf-tab:complete:bat:*' fzf-preview '([[ -d $realpath ]] && ls --color $realpath || bat --style=numbers --color=always $realpath)'
        zstyle ':fzf-tab:complete:z:*' fzf-preview '([[ -d $realpath ]] && ls --color $realpath || bat --style=numbers --color=always $realpath)'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:*' fzf-min-height 15
      '';
      order = 102;
    };

    custom.zsh.configFiles.".zshrc".fragments."fzf-completions" = lib.mkIf zshEnabled {
      text = ''
        # fzf completions (managed by custom/fzf module)

        source <(${lib.getExe cfg.package} --zsh)
      '';
      order = 1004;
    };

    home.sessionVariables.FZF_DEFAULT_OPTS = ''
      --style=full
      --height=90%
      --layout=reverse
      --prompt="❯"
      --pointer="❯"
      --marker="❯"
      --color=pointer:blue
      --preview-window=right,80%
    '';
  };
}
