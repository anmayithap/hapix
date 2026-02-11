# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > async-prompt]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    pkgs,
    ...
  }: {
    options = {
      programs.fish.async-prompt-plugin = {
        enable = lib.mkEnableOption "async-prompt plugin. Make your prompt asynchronous.";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The plugin package itself.";
          default = pkgs.fetchFromGitHub {
            owner = "acomagu";
            repo = "fish-async-prompt";
            rev = "v1.3.0";
            sha256 = "sha256-HWW9191RP//48HkAHOZ7kAAAPSBKZ+BW2FfCZB36Y+g=";
          };
        };
      };
    };
  };
}
