# =========================================================================
# == USER PROFILE: rusel (Tool Management - mise)
# This module configures 'mise' (formerly rtx), a high-performance
# replacement for asdf. It manages multiple versions of language runtimes
# (Node.js, Ruby, Python, etc.) and CLI tools, providing a bridge for
# legacy projects or non-Nix toolchains.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.mise = {
      # ### Core Activation
      # Enforce 'mise' as the primary polyglot tool manager.
      # Using `lib.mkForce` ensures that this development dependency
      # is always active for the "rusel" profile, overriding any
      # generic system defaults.
      enable = lib.mkForce true;

      # Note: This module complements the 'direnv.mise.enable' setting
      # established in the direnv module, allowing mise-managed tools
      # to be automatically loaded upon entering a project directory.
    };
  };
}
