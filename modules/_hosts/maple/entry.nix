{self, ...}: {
  flake.darwinConfigurations.maple = self.lib.confFactory.mkDarwinSilicon "maple";
}
