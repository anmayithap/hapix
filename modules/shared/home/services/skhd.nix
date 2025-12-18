_: let
  services = {
    lib,
    config,
    ...
  }: let
    packagesExists = config.home.packages != null;

    alacrittyBinding = lib.optionalString config.programs.alacritty.enable ''
      lcmd + lalt - t : open -a Alacritty
    '';

    googleChromeBinding =
      lib.optionalString
      (packagesExists && lib.any (p: p.name == "google-chrome") config.home.packages) ''
        lcmd + lalt - b : open -a Google\ Chrome
      '';

    allBindings = [
      alacrittyBinding
      googleChromeBinding
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
  };
in {
  flake.modules.homeManager = {inherit services;};
}
