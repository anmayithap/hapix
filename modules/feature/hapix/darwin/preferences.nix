#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> darwin-preferences] darwin preferences preset
#: ----------------------------------------------------------------------------
{hapix, ...}: {
  hapix.darwin-preferences = {
    includes = [
      hapix.darwin-preferences.networking
      hapix.darwin-preferences.keyboard
      hapix.darwin-preferences.defaults
      hapix.darwin-preferences.power
      hapix.darwin-preferences.security
    ];
  };
}
