{profile, ...}: {
  imports = [
    ./shared
  ];

  home = {
    inherit (profile) username;

    stateVersion = "24.11";

    inherit (profile) homeDirectory;
  };

  programs.home-manager.enable = true;
}
