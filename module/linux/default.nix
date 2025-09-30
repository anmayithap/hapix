{common-tools, ...}: {
  imports =
    (common-tools.scanPaths ./.)
    ++ [
      ../base.nix
    ];
}
