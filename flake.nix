#: ----------------------------------------------------------------------------
#: ## [ROOT] flake entry point
#: ----------------------------------------------------------------------------
#: Required for backward compatibility with nix flakes
{
  outputs = _: import ./.;
}
