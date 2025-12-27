# =========================================================================
# == USER PROFILE: rusel (Data Processing Adapter - yq)
# This module integrates 'yq' into the Zsh environment. It establishes
# a unified alias that redirects 'jq' calls to 'yq', providing a single,
# high-performance processor for YAML, JSON, XML, and other structured
# data formats.
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
    programs.zsh.shellAliases = {
      # ### Tool Unification (jq -> yq)
      # We map the standard 'jq' command to the 'yq' binary.
      #
      # Benefits:
      # - Universal Processing: Unlike the original 'jq', which is limited
      #   to JSON, 'yq' is a superset that handles YAML, JSON, XML, CSV,
      #   and TOML using a similar syntax.
      # - Consistency: Ensures that the same powerful filtering and
      #   transformation logic can be applied regardless of the input format.
      # - Reliability: By using '${lib.getExe pkgs.yq}', the alias points
      #   directly to the Nix-managed binary, ensuring cross-platform
      #   stability across Darwin and NixOS.
      jq = "${lib.getExe pkgs.yq}";
    };
  };
}
