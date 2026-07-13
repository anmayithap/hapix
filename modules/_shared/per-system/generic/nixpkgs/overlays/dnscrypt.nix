# ----------------------------------------------------------------------------
# ## Generic Module: [Nixpkgs > Overlays > DNSCrypt]
# ----------------------------------------------------------------------------
# Adds the dnscrypt blacklist generation package
# See: `modules/packages/dnscrypt/generate-domains-blocklist.nix`
{inputs, ...}: {
  flake.modules.generic.dnscrypt-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      (
        _: prev: {
          inherit (inputs.self.packages.${prev.pkgs.stdenv.hostPlatform.system}) generate-domains-blocklist;
        }
      )
    ];
  };
}
