#: ----------------------------------------------------------------------------
#: ## [FEATURE -> hapix -> nixpkgs] nixpkgs preset
#: ----------------------------------------------------------------------------
{self, ...}: {
  hapix.nixpkgs = {
    os = {
      nixpkgs = {
        overlays = [
          self.overlays.default
        ];
      };
    };
  };
}
