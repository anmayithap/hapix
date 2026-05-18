#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> darwin-preferences -> power] darwin power preset
#: ----------------------------------------------------------------------------
{
  hapix.darwin-preferences.power = {
    darwin = {lib, ...}: let
      D = lib.mkDefault;
    in {
      power = {
        #: `sustemsetup -setRestartFreeze <value>`
        #: Whether to restart the computer after a system freeze.
        restartAfterFreeze = D true;

        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/power/sleep.nix
        sleep = {
          #: `systemsetup -setComputerSleep <value>`
          computer = D 30;
          #: `systemsetup -setDisplaySleep <value>`
          display = D 30;
          #: `systemsetup -setHardDiskSleep <value>`
          harddisk = D 30;

          #: `systemsetup -setAllowPowerButtonToSleepComputer <value>`
          allowSleepByPowerButton = D true;
        };
      };
    };
  };
}
