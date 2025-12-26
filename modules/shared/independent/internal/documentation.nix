# =========================================================================
# == SHARED MODULE: System Documentation
# This module controls the generation of system-wide documentation. By
# default, it disables manual pages, info files, and technical docs to
# reduce the overall system closure size and accelerate the rebuild
# process, especially on resource-constrained or minimalist environments.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Documentation Logic Definition
  # -----------------------------------------------------------------------
  # We define a unified documentation policy. While documentation is
  # helpful, generating it during every system rebuild can significantly
  # increase evaluation time and storage consumption.
  documentation = {lib, ...}: {
    documentation = {
      # ### Global Documentation Toggle
      # Disables the installation of any system documentation.
      # Using `lib.mkDefault` allows specific hosts (e.g., a primary
      # workstation or a server where local help is critical) to
      # re-enable this feature easily.
      enable = lib.mkDefault false;

      # ### Specific Documentation Formats
      # Explicitly disable 'doc' (HTML/PDF) and 'info' formats.
      # This ensures that even if the global toggle is modified,
      # these heavier formats remain inactive unless explicitly needed.
      doc.enable = lib.mkDefault false;
      info.enable = lib.mkDefault false;

      # Note: Man pages are also covered by the global 'enable' flag,
      # but can be granularly controlled via 'man.enable' if required.
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # We register this documentation policy into both the NixOS and Darwin
  # registries. This ensures that your "minimalist infrastructure"
  # philosophy is applied consistently across Linux and macOS hosts.
  flake.modules = {
    # NixOS (Linux) registry.
    nixos.documentation = documentation;

    # Darwin (macOS) registry.
    darwin.documentation = documentation;
  };
}
