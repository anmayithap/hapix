#: ----------------------------------------------------------------------------
#: ## [HOSTS -> maple -> host] `host` aspect for `maple` namespace
#: ----------------------------------------------------------------------------
{
  hapix,
  maple,
  ...
}: {
  maple.host = {
    includes = [
      hapix.darwin
      hapix.nix
      hapix.gc
      hapix.nixpkgs
      hapix.nix-index

      maple.preferences.networking
    ];
  };
}
