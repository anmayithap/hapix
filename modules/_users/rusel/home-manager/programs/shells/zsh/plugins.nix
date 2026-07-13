# ----------------------------------------------------------------------------
# ## Home Manager: Programs > Shells > rusel > zsh section configuration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-zsh = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.zsh;
  in {
    programs.zsh = {
      plugins = lib.mkIf cfg.enable (
        lib.mkBefore [
          {
            name = "fast-syntax-highlighting";
            src = pkgs.zsh-fast-syntax-highlighting;
            file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
          }
          {
            name = "zsh-completions";
            src = pkgs.zsh-completions;
            completions = ["share/zsh/site-functions"];
          }
          {
            name = "zsh-you-should-use";
            src = pkgs.zsh-you-should-use;
            file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
          }
          {
            name = "nix-zsh-completions";
            src = pkgs.nix-zsh-completions;
            file = "share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh";
            completions = ["share/zsh/site-functions"];
          }
        ]
      );

      sessionVariables = {
        YSU_MESSAGE_POSITION = "after";
      };
    };
  };
}
