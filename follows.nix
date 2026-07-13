#: ----------------------------------------------------------------------------
#: ## [ROOT] inputs follows
#: ----------------------------------------------------------------------------
#: Declares an attribute set that can be used to drive input resolution, for
#: example to use local checkout or to specify flake-like follows.
{
  #: Required for `flake-parts` to work
  nixpkgs-lib.follows = "nixpkgs";
}
