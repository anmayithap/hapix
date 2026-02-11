# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.rusel-home-manager = {config, ...}: {
    home-manager.users.${config.user-meta.username} = {
      imports = with inputs.self.modules.homeManager;
        [
          rusel-containerization
          rusel-keyboard
          rusel-secrets
          rusel-notes
          rusel-security
          rusel-development
          rusel-shells
          rusel-terminal-emulators
          rusel-tui
          rusel-utils
          rusel-editors
          rusel-xdg
        ]
        ++ [
          inputs.self.modules.generic.rusel-user-meta
        ];
    };
  };
}
