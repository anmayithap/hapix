# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > direnv]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.direnv = {
    lib,
    config,
    ...
  }: {
    programs.direnv = {
      # ## Disabled by default, to be set later in the user configuration.
      enable = lib.mkDefault false;

      # ## Enable direnv logging by default.
      silent = lib.mkDefault true;

      # ## Enable direnv mise integration.
      # `use_mise`
      mise = {
        enable = lib.mkDefault config.programs.mise.enable;
      };

      # ## Enable direnv nix-direnv integration.
      # `use_nix`
      nix-direnv = {
        enable = lib.mkDefault true;
      };
    };
  };
}
