{
  lib,
  config,
  ...
}: let
  packagesExists = config.home.packages != null;

  terminalBinding = lib.optionalString config.programs.alacritty.enable ''
    lcmd + lalt - t : open -a Alacritty
  '';

  browserBinding =
    lib.optionalString (
      packagesExists
      && lib.any (p: p.name == "google-chrome" || p.pname == "google-chrome") config.home.packages
    ) ''
      lcmd + lalt - b : open -a Google\ Chrome
    '';

  allBindings = [
    terminalBinding
    browserBinding
  ];

  activeBindings = lib.filter (str: str != "") allBindings;

  generatedConfig = lib.strings.concatStringsSep "\n" activeBindings;

  finalConfig =
    if generatedConfig == ""
    then ""
    else generatedConfig + "\n";
in {
  services.skhd = {
    enable = lib.mkDefault true;
    config = lib.mkDefault finalConfig;
  };
}
