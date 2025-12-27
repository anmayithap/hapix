# =========================================================================
# == SHARED DARWIN MODULE: nix-homebrew User Integration
# This module synchronizes Homebrew ownership with the primary user
# identity. It ensures that the nix-homebrew manager assigns the
# Homebrew prefix (e.g., /opt/homebrew) to the "rusel" user, enabling
# seamless binary execution and declarative tap management.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## nix-homebrew Ownership Logic
  # -----------------------------------------------------------------------
  module = {
    lib,
    config,
    ...
  }: let
    # We extract the 'username' from our unified 'user-meta' profile.
    # This ensures that the Homebrew prefix ownership always follows
    # the primary system identity.
    inherit (config.user-meta) username;
  in {
    # ### Homebrew Prefix Ownership
    # The 'nix-homebrew.user' option determines which local user
    # owns the Homebrew installation and its associated files.
    #
    # We use `lib.mkForce` to ensure this specific user identity
    # overrides any generic or default settings. This is critical for
    # 'nix-homebrew' to correctly set the permissions of the
    # /opt/homebrew (on Apple Silicon) or /usr/local (on Intel)
    # directories during the first system activation.
    nix-homebrew.user = lib.mkForce username;
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # This module is registered within the 'rusel' Darwin profile.
  # It serves as a vital "glue" component, tying your declarative
  # third-party package management to your primary user account.
  flake.modules.darwin.rusel.imports = [
    module
  ];
}
