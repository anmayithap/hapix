{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devshells.default = {
      name = "hapix";
      packages = [
        pkgs.nil
        pkgs.nh

        config.treefmt.build.wrapper
      ];

      commands = [
        {
          name = "nixh";
          help = "Nix Helper (wrapped nh)";
          category = "utils";

          command = "${pkgs.nh}/bin/nh $@";
        }
      ];

      devshell.startup.pre-commit.text = config.pre-commit.installationScript;
    };
  };
}
