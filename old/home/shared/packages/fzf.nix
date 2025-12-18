{
  lib,
  config,
  ...
}: let
  zinitEnabled = config.custom.zinit.enable;
in {
  custom.fzf = {
    enable = lib.mkDefault true;
  };

  custom.zinit.plugins = lib.mkIf zinitEnabled [
    "zinit light Aloxaf/fzf-tab"
  ];
}
