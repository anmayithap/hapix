# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim]
# -----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    ...
  }: {
    wrappers.neovim = {
      enable = lib.mkDefault false;

      package = lib.mkDefault inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;

      # ## Enabling and disabling neovim providers if needed
      # Providers allows integration with external applications/plugins
      # written in specific languages.
      hosts = {
        neovide.nvim-host.enable = lib.mkDefault false;
        node.nvim-host.enable = lib.mkDefault false;
        perl.nvim-host.enable = lib.mkDefault false;
        python3.nvim-host.enable = lib.mkDefault false;
        ruby.nvim-host.enable = lib.mkDefault false;
      };

      settings = {
        wrapMode = lib.mkDefault "development";
      };

      # ## The wrapper implementation to use.
      # - binary: Use the binary wrapper implementation.
      # - shell:  Use the shell wrapper implementation.
      # - nix:    Use the nix wrapper implementation.
      wrapperImplementation = lib.mkDefault "binary";
    };
  };
}
