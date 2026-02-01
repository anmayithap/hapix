# ---------------------------------------------------------------------------------
# ## Pre-Commit: Setting up pre-commit hooks
# ---------------------------------------------------------------------------------
{
  perSystem = {
    config,
    lib,
    ...
  }: {
    pre-commit = {
      settings = {
        hooks = {
          # ## Prevent very large files to be committed (e.g. binaries)
          check-added-large-files = {
            enable = lib.mkDefault true;
          };

          # ## Ensure that all non-binary executables have shebangs.
          check-executables-have-shebangs = {
            enable = lib.mkDefault true;
          };

          # ## Check syntax of JSON files.
          check-json = {
            enable = lib.mkDefault true;
          };

          # ## Check for files that contain merge conflict strings.
          check-merge-conflicts = {
            enable = lib.mkDefault true;
          };

          # ## Ensure that all (non-binary) files with a shebang are executable.
          check-shebang-scripts-are-executable = {
            enable = lib.mkDefault true;
          };

          # ## Find broken symlinks.
          check-symlinks = {
            enable = lib.mkDefault true;
          };

          # ## Check syntax of TOML files.
          check-toml = {
            enable = lib.mkDefault true;
          };

          # ## Ensure that links to VCS websites are permalinks.
          check-vcs-permalinks = {
            enable = lib.mkDefault true;
          };

          # ## Check syntax of YAML files.
          check-yaml = {
            enable = lib.mkDefault true;
          };

          # ## Check whether the current commit message follows committing rules.
          commitizen = {
            enable = lib.mkDefault true;
          };

          # ## Detect AWS credentials from the AWS cli credentials file.
          detect-aws-credentials = {
            enable = lib.mkDefault true;
          };

          # ## Detect the presence of private keys.
          detect-private-keys = {
            enable = lib.mkDefault true;
          };

          # ## Ensures that a file is either empty, or ends with a single newline.
          end-of-file-fixer = {
            enable = lib.mkDefault true;
          };

          # ## Remove UTF-8 byte order marker.
          fix-byte-order-marker = {
            enable = lib.mkDefault true;
          };

          # ## Run health checks on your flake-powered Nix projects.
          flake-checker = {
            enable = lib.mkDefault true;
          };

          # ## Resolve mixed line endings.
          mixed-line-endings = {
            enable = lib.mkDefault true;
          };

          # ## One CLI to format the code tree.
          treefmt = {
            enable = lib.mkDefault true;
            package = lib.mkDefault config.treefmt.build.wrapper;
          };

          # ## Trim trailing whitespace.
          trim-trailing-whitespace = {
            enable = lib.mkDefault true;
          };
        };
      };
    };
  };
}
