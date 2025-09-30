{
  lib,
  profile,
  ...
}: {
  networking = {
    computerName = lib.mkDefault profile.hostname;
    hostName = lib.mkDefault profile.hostname;
    localHostName = lib.mkDefault profile.hostname;
  };
}
