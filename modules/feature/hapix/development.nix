#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> development]
#: ----------------------------------------------------------------------------
{hapix, ...}: {
  #: `home-manager` development preset
  hapix.hm-development = {
    includes = [
      hapix.ignoring
    ];

    ignore = {
      globs = [
        "*~"
        "*.swp"
        ".DS_Store"
        ".envrc"
        ".env"
      ];
    };

    homeManager = {
      self',
      host,
      user,
      lib,
      config,
      ...
    }: let
      D = lib.mkDefault;
      B = lib.mkBefore;

      cpuCores = host.spec.cores or null;
      gitUserName = user.git.name or null;
      gitUserEmail = user.git.email or null;

      extendedGit =
        self'.packages.git.apply
        {
          settings = {
            user = {
              name = D gitUserName;
              email = D gitUserEmail;
            };
          };
        };
    in {
      programs = {
        git = {
          enable = D true;
          package = D extendedGit.wrapper;
          attributes = B [
            "* text eol=lf"
          ];
          lfs.enable = D true;
        };

        direnv = {
          enable = D true;

          silent = D true;

          #: integrations
          nix-direnv = {
            enable = D true;
          };
        };

        uv = {
          enable = D true;

          settings = {
            add-bounds = D "minor"; # ## The default version specifier: `>=1.2.3, <1.3.0`
            cache-dir = D "${config.xdg.cacheHome}/uv";
            compile-bytecode = D true;
            concurrent-builds = D cpuCores;
            concurrent-installs = D cpuCores;
            #: Validate the Python environment,
            #: to detect packages with missing dependencies and other issues.
            strict = D true;
          };
        };
      };
    };
  };
}
