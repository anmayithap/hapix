# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.utils = {
    imports = [
      inputs.self.modules.homeManager.bat
      inputs.self.modules.homeManager.btop
      inputs.self.modules.homeManager.duf
      inputs.self.modules.homeManager.dust
      inputs.self.modules.homeManager.eza
      inputs.self.modules.homeManager.fastfetch
      inputs.self.modules.homeManager.fd
      inputs.self.modules.homeManager.fzf
      inputs.self.modules.homeManager.ripgrep
      inputs.self.modules.homeManager.starship
      inputs.self.modules.homeManager.tealdeer
      inputs.self.modules.homeManager.yq
      inputs.self.modules.homeManager.zellij
      inputs.self.modules.homeManager.zoxide
      inputs.self.modules.homeManager.glow
      inputs.self.modules.homeManager.p7zip
      inputs.self.modules.homeManager.timg
      inputs.self.modules.homeManager.delta
      inputs.self.modules.homeManager.man
    ];
  };
}
