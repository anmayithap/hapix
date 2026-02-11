# ----------------------------------------------------------------------------
# ## Rusel User Module: [As Module]
# ----------------------------------------------------------------------------
# Importing all needed rusel modules
{inputs, ...}: {
  flake.modules = {
    # ## Generic modules, which could be used in any other modules.${class} class
    generic.rusel.imports = with inputs.self.modules.generic; [
      rusel-user
      rusel-user-meta
      rusel-preferences
      rusel-dns

      rusel-home-manager
    ];

    darwin.rusel.imports = with inputs.self.modules.darwin; [
      rusel-user
      rusel-preferences
      rusel-dns
      rusel-homebrew
      rusel-secrets
      rusel-browsing
      rusel-messaging
      rusel-vpn
      rusel-utils
    ];
  };
}
