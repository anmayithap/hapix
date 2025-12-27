# =========================================================================
# == USER PROFILE: rusel (System Information Adapter - fastfetch)
# This module integrates 'fastfetch' into the Zsh environment. It
# establishes a high-level alias for rapid system information retrieval,
# providing a modern and performant alternative to the legacy 'neofetch'.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Shell Integration (Zsh)
    # -----------------------------------------------------------------------
    programs.zsh = {
      # ### Tool Redirection (Aliases)
      shellAliases = {
        # #### ff -> fastfetch
        # Provides a two-letter shortcut to display system metadata
        # (OS version, kernel, uptime, hardware specs, etc.).
        #
        # Benefits:
        # - Speed: Fastfetch is written in C and executes significantly
        #   faster than shell-based fetch utilities.
        # - Reliability: By using '${lib.getExe pkgs.fastfetch}', the
        #   alias remains functional even if the binary is not globally
        #   present in the system PATH.
        ff = "${lib.getExe pkgs.fastfetch}";
      };
    };
  };
}
