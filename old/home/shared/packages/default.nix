{
  pkgs,
  common-tools,
  ...
}: {
  imports = common-tools.scanPaths ./.;

  home.packages = with pkgs; [
    # Browsing tools
    google-chrome

    # Messaging tools
    telegram-desktop

    # Development tools
    obsidian
    python313Packages.ipython

    # Networking tools
    httpie

    # Misc
    xclip
    duf
    dust
    tldr
    yq
    rage
  ];
}
