# ----------------------------------------------------------------------------
# ## VSCode Profile: Default Profile
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.vscode.profiles.default = {
      enableExtensionUpdateCheck = lib.mkForce false;
      enableMcpIntegration = lib.mkForce false;
      enableUpdateCheck = lib.mkForce false;

      extensions = with pkgs.vscode-extensions; [
        teabyii.ayu
        mads-hartmann.bash-ide-vscode
        streetsidesoftware.code-spell-checker
        intellsmi.comment-translate
        mkhl.direnv
        swyddfa.esbonio
        tamasfe.even-better-toml
        anhkhoakz.gi-better
      ];
    };
  };
}
