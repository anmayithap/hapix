# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > done]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    pkgs,
    ...
  }: let
    # ## Specific notifier for done plugin
    notifierModule = lib.types.submodule {
      options = {
        enable = lib.mkEnableOption "Specific notifier";
        package = lib.mkPackageOption pkgs "terminal-notifier" {
          default = null;
          nullable = true;
          extraDescription = ''
            If you want notifications with icons on Darwin, please set package to `pkgs.terminal-notifier`.
          '';
        };
      };
    };
  in {
    options = {
      programs.fish.done-plugin = {
        enable = lib.mkEnableOption "done plugin, to show notifications when long processes finish";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The plugin package itself.";
          default = pkgs.fetchFromGitHub {
            owner = "franciscolourenco";
            repo = "done";
            rev = "1.21.1";
            sha256 = "sha256-GZ1ZpcaEfbcex6XvxOFJDJqoD9C5out0W4bkkn768r0=";
          };
        };
        notifier = lib.mkOption {
          type = notifierModule;
          default = {};
          example = lib.literalExpression ''
            {
              enable = true;
              package = pkgs.terminal-notifier;
            }
          '';
          description = ''
            A specific notifier used by the done plugin.

            Note: So far, notifier has only been defined for Darwin systems.
          '';
        };
      };
    };
  };
}
