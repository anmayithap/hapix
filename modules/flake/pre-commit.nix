# ----------------------------------------------------------------------------
# ## Pre-Commit: Setting up pre-commit hooks
# ----------------------------------------------------------------------------
{
  perSystem = {
    config,
    lib,
    ...
  }: {
    pre-commit = {
      settings = {
        hooks = {
          # -----------------------------------------------------------------------
          # ## Nix Hooks
          # -----------------------------------------------------------------------
          treefmt = {
            enable = lib.mkDefault true;
            package = lib.mkDefault config.treefmt.build.wrapper;

            settings = {
              # Let it format without having to re-commit
              fail-on-change = lib.mkDefault false;
            };
          };

          flake-checker.enable = lib.mkDefault true;

          # -----------------------------------------------------------------------
          # ## Commit Hooks
          # -----------------------------------------------------------------------
          commitizen.enable = lib.mkDefault true;

          # -----------------------------------------------------------------------
          # ## git-hooks-nix Hooks
          # -----------------------------------------------------------------------

          check-added-large-files.enable = lib.mkDefault true;

          check-json.enable = lib.mkDefault true;

          check-merge-conflicts.enable = lib.mkDefault true;

          check-symlinks.enable = lib.mkDefault true;

          check-toml.enable = lib.mkDefault true;

          check-yaml.enable = lib.mkDefault true;

          detect-private-keys.enable = lib.mkDefault true;

          end-of-file-fixer.enable = lib.mkDefault true;

          trim-trailing-whitespace.enable = lib.mkDefault true;

          fix-byte-order-marker.enable = lib.mkDefault true;

          markdownlint.enable = lib.mkDefault true;

          mdformat.enable = lib.mkDefault true;

          mdl.enable = lib.mkDefault true;
        };
      };
    };
  };
}
