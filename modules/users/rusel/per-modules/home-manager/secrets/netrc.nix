{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        ".netrc" = {
          file = "${secrets}/.netrc.age";
          mode = "0500";
          path = "${homeDirectory}/.netrc";
          symlink = true;
        };
      };
    };
  };
}
