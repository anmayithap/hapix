# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-utils = {
    imports = [
      inputs.self.modules.homeManager.rusel-bat
      inputs.self.modules.homeManager.rusel-btop
      inputs.self.modules.homeManager.rusel-duf
      inputs.self.modules.homeManager.rusel-dust
      inputs.self.modules.homeManager.rusel-eza
      inputs.self.modules.homeManager.rusel-fastfetch
      inputs.self.modules.homeManager.rusel-fd
      inputs.self.modules.homeManager.rusel-fzf
      inputs.self.modules.homeManager.rusel-ripgrep
      inputs.self.modules.homeManager.rusel-starship
      inputs.self.modules.homeManager.rusel-tealdeer
      inputs.self.modules.homeManager.rusel-yq
      inputs.self.modules.homeManager.rusel-zellij
      inputs.self.modules.homeManager.rusel-zoxide
      inputs.self.modules.homeManager.rusel-glow
      inputs.self.modules.homeManager.rusel-p7zip
      inputs.self.modules.homeManager.rusel-timg
      inputs.self.modules.homeManager.rusel-delta
    ];
  };
}
