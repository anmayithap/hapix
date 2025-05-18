{
  lib,
  profile,
  ...
}: let
  jobDevDirectory = "${profile.homeDirectory}/dev/job";
in {
  programs.git = {
    enable = lib.mkDefault true;
    lfs.enable = lib.mkDefault true;

    userName = lib.mkDefault profile.username;
    userEmail = lib.mkDefault profile.email;

    includes = [
      {
        path = "${jobDevDirectory}/.gitconfig";
        condition = "gitdir:${jobDevDirectory}/";
      }
    ];

    attributes = lib.mkDefault [
      "* text eol=lf"
    ];

    delta = {
      enable = lib.mkDefault true;
      options = lib.mkDefault {
        diff-so-fancy = lib.mkDefault true;
        line-numbers = lib.mkDefault true;
        true-color = lib.mkDefault "always";
      };
    };

    extraConfig = lib.mkDefault {
      init.defaultBranch = "master";
      pull.rebase = true;

      url = {
        "ssh://git@github.com/anmayithap" = {
          insteadOf = "https://github.com/anmayithap";
        };
      };
    };

    aliases = lib.mkDefault {
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -a -m";
      dc = "diff --cached";

      amend = "commit --amend -m";
      unstage = "reset HEAD --";
      merged = "branch --merged";
      unmerged = "branch --no-merged";
      nonexists = "remote prune origin --dry-run";

      delmerged = ''! git branch --merged | egrep -v "(^\*|main|master|dev|staging)" | xargs git branch -d'';
      delnonexist = "remote prune origin";

      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };
}
