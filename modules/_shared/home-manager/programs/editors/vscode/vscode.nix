# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > vscode]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.vscode = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.vscode;
  in {
    options = {
      programs.vscode = {
        # ## This option allows you to switch vscode between control via nix and via vscode directly.
        standalone = lib.mkEnableOption "standalone";
      };
    };

    config = lib.mkIf cfg.enable {
      # ## Define package as unfree by default.
      unfree = [
        cfg.package
      ];

      programs.vscode = {
        # ## Disable configured vscode profiles if standalone is enabled.
        profiles =
          if cfg.standalone
          then lib.mkForce {}
          else cfg.profiles;

        # ## Switch mutable and immutable extensions directory by standalone option.
        mutableExtensionsDir =
          if cfg.standalone
          then lib.mkForce true
          else cfg.mutableExtensionsDir;
      };
    };
  };
}
