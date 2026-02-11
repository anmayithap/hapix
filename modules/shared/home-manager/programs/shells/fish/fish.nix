# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    pkgs,
    config,
    ...
  }: {
    programs.fish = {
      enable = lib.mkDefault true;

      # ## Default enable fish completions
      generateCompletions = lib.mkDefault true;

      # ## Prefer abbreviations over aliases
      preferAbbrs = lib.mkDefault true;

      # ## Enable done plugin
      done-plugin = {
        enable = lib.mkDefault true;
        notifier = {
          enable = lib.mkIf pkgs.stdenv.isDarwin (lib.mkDefault true);
          package = lib.mkIf pkgs.stdenv.isDarwin (lib.mkForce pkgs.terminal-notifier);
        };
      };

      # ## Enable async-prompt plugin
      # if starship is enabled, async-prompt is not needed
      async-prompt-plugin.enable = lib.mkDefault (!config.programs.starship.enable);

      # ## Enable sponge plugin
      sponge-plugin.enable = lib.mkDefault true;

      # ## Enable fzf-fish plugin
      fzf-fish-plugin.enable = lib.mkDefault true;

      # ## Enable preview.fish plugin
      preview-fish-plugin.enable = lib.mkDefault true;

      # ## Set default theme
      theme = lib.mkDefault "ayu";

      functions = {
        # ## Add `multi-cd` function
        # Which allows you to perform dots disclosure as a cd command.
        #
        # Example:
        #   ...  -> cd ../../../
        #   .... -> cd ../../../../
        multi_cd = {
          body = lib.mkDefault "echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)";
          description = "Perform dots disclosure as a cd command";
        };
        # ## Disable fish_greeting by default
        fish_greeting = {
          body = lib.mkDefault "";
          description = "Configure fish_greeting variable";
        };
        # ## Configure keybindings by custom function
        fish_hapix_key_bindings = {
          body = lib.mkDefault "fish_vi_key_bindings insert";
          description = "Set keybindings to vi mode which startup in insert mode";
        };
      };

      shellAbbrs = {
        # ## Register `multi_cd` abbr
        "dotdot" = {
          regex = "^\\.\\.+$";
          function = "multi_cd";
        };
      };

      shellInit = lib.mkBefore ''
        # ## Register custom keybindings
        set -g fish_key_bindings fish_hapix_key_bindings
      '';
    };
  };
}
