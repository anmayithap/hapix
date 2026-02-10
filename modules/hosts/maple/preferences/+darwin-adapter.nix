# ----------------------------------------------------------------------------
# ## Maple Host Module: Configures darwin state version.
# This means that the nixpkgs version is locked to the latest stable version.
# ____________________________________________________________________________
# Attention: Do not change this value unless you know what you are doing.
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.maple = {lib, ...}: {
    system = {
      stateVersion = lib.mkForce 6;
    };
  };
}
