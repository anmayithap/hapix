#: ----------------------------------------------------------------------------
#: ## [FEATURE -> hapix -> darwin-preferences -> keyboard] darwin keyboard preset
#: ----------------------------------------------------------------------------
#: See `nix-darwin`: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/keyboard.nix
{
  hapix.darwin-preferences.keyboard = {
    darwin = {lib, ...}: let
      D = lib.mkDefault;
    in {
      system = {
        keyboard = {
          #: `hidutil property --set '{"UserKeyMapping":<value>}'
          #: Enabling custom key mapping configuration
          enableKeyMapping = D true;
          remapCapsLockToControl = D true;
        };

        defaults = {
          #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
          NSGlobalDomain = {
            InitialKeyRepeat = D 15;
            KeyRepeat = D 2;
            "com.apple.keyboard.fnState" = D false;
          };
          #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/hitoolbox.nix
          hitoolbox = {
            #: Chooses what happens when you press the Fn key on the keyboard.
            #: * `Change Input Source`
            #: * `Do Nothing`
            #: * `Show Emoji & Symbols`
            #: * `Start Dictation`
            AppleFnUsageType = D "Change Input Source";
          };
        };
      };
    };
  };
}
