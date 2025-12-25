{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) fullname;
    inherit (config.user-meta) email;
  in {
    programs.git = {
      enable = lib.mkForce true;
      lfs.enable = lib.mkForce true;

      attributes = lib.mkBefore [
        "* text eol=lf"
      ];

      ignores = lib.mkBefore [
        ".DS_Store"
        ".direnv"
        ".vscode"
        ".envrc"
        ".env"
      ];

      maintenance = {
        enable = lib.mkForce true;
      };

      settings = {
        user = {
          name = lib.mkForce fullname;
          email = lib.mkForce email;
        };

        init = {
          defaultBranch = lib.mkForce "master";
        };

        pull = {
          rebase = lib.mkForce true;
        };

        push = {
          autoSetupRemote = lib.mkForce true;
          followTags = lib.mkForce true;
        };

        alias = {
          b = "branch";
          co = "checkout";
          cob = "checkout -b";
          st = "status";
          ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
          ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
          cm = "commit";
          cma = "commit -a";
          cmm = "commit -m";
          cmma = "commit -a -m";
          df = "diff";
          dfch = "diff --cached";
          amend = "commit --amend -m";
          unstage = "reset HEAD --";
          merged = "branch --merged";
          unmerged = "branch --no-merged";
          non-exists = "remote prune $1 --dry-run";
          del-merged = ''! git branch --merged | egrep -v "(^\*|main|master|dev|staging|develop)" | xargs git branch -d'';
          del-non-exists = "remote prune $1";
          sub-update = "submodule update --init --recursive";
          sub-foreach = "submodule foreach";
        };
      };

      signing = {
        format = "ssh";
      };
    };
  };
}
