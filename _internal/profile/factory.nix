/*
This module provides a factory function for creating profiles.
Profile contains information which can be used to create the profile directory structure and files.

Profile structure:
  - system: The target system of this profile, e.g., aarch64-darwin or x86_64-linux.
  - hostname: The host name of the machine where this profile will be applied.
  - username: The user name that will own all files created by this profile.
  - fullname: Full name of the owner user.
  - email: Email address of the owner user.

Functions:
1. mkProfile: {system, hostname, ...}@args -> attrset
   This function creates a profile from given arguments.
*/
{
  constants,
  validation-tools,
  available-systems,
  common-tools,
}: let
  inherit (common-tools) isDarwinBySystemName isLinuxBySystemName;

  mkHomeDirectory = {
    username,
    isDarwin,
  }:
    if isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  mkProfile = {
    system,
    hostname,
    ...
  } @ args: let
    isDarwin = isDarwinBySystemName system;
    isLinux = isLinuxBySystemName system;

    username = args.username or constants.username;
    fullname = args.fullname or constants.fullname;
    email = args.email or constants.email;
  in
    assert validation-tools.validate
    (builtins.elem system available-systems)
    "The system name '${system}' is not supported. Supported systems include: ${toString available-systems}.";
    {
      inherit system hostname username fullname email;

      homeDirectory = mkHomeDirectory {
        inherit username isDarwin;
      };
    };
in {
  inherit mkProfile;
}
