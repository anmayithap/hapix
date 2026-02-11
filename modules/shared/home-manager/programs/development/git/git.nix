# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > git]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.git = {lib, ...}: {
    programs.git = {
      # ## Disabled by default, to be set later in the user configuration.
      enable = lib.mkDefault false;

      # ## Enable git Large File Storage (LFS).
      lfs.enable = lib.mkDefault true;

      # ## Global defining git attributes.
      attributes = lib.mkBefore [
        "* text eol=lf"
      ];

      # ## Global defining git ignores.
      ignores = lib.mkBefore [
        ".DS_Store"
        ".envrc"
        ".env"
      ];

      # ## Enable automatic git maintenance.
      maintenance.enable = lib.mkDefault true;

      settings = {
        init.defaultBranch = lib.mkDefault "master";

        pull.rebase = lib.mkDefault true;

        push = {
          autoSetupRemote = lib.mkDefault true;
          followTags = lib.mkForce true;
        };

        diff = {
          colorMoved = lib.mkDefault "default";
        };

        merge = {
          conflictStyle = lib.mkDefault "zdiff3";
        };
      };
    };
  };
}
