{
  profile,
  common-tools,
  ...
}: {
  imports =
    (common-tools.scanPaths ./.)
    ++ [
      ../../hosts/${profile.username}-${profile.hostname}
    ];
}
