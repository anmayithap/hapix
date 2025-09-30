{
  pkgs,
  common-tools,
  ...
}: {
  imports = common-tools.scanPaths ./.;

  environment.systemPackages = with pkgs; [
    # Languages
    python313
    go

    # File system tools
    ncdu

    # Networking tools
    wget
    curl
    socat

    # Misc tools
    rsync
  ];
}
