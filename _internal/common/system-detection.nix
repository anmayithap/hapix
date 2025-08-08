/*
This module defines custom functions for detecting the type of system.
It includes functions to check if the system is Darwin (macOS) or Linux.

Functions:
1. isDarwinBySystemName: system -> bool
  Checks if the system name ends with "darwin".

2. isLinuxBySystemName: system -> bool
  Checks if the system name ends with "linux".
*/
{lib}: let
  isDarwinBySystemName = system: lib.strings.hasSuffix "darwin" system;
  isLinuxBySystemName = system: lib.strings.hasSuffix "linux" system;
in {
  inherit isDarwinBySystemName isLinuxBySystemName;
}
