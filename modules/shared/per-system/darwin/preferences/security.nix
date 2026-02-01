# ----------------------------------------------------------------------------
# ## Darwin Security Preferences Module
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.security = {lib, ...}: {
    security.pam.services.sudo_local = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-security.pam.services.sudo_local.touchIdAuth
      touchIdAuth = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-security.pam.services.sudo_local.reattach
      reattach = lib.mkDefault true;
    };
  };
}
