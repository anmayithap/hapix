{
  lib,
  common-tools,
  ...
}: {
  imports = common-tools.scanPaths ./.;

  xdg = {
    enable = lib.mkDefault true;
  };
}
