#: ----------------------------------------------------------------------------
#: ## [ROOT] nix entry point
#: ----------------------------------------------------------------------------
#: Well, I decided to stop using Nix Flakes as a trial run.
#: Overall, I find it more of a hassle than a help so far.
let
  sources = import ./npins;
  with-inputs = import sources.with-inputs sources (import ./follows.nix);
  outputs = raw-inputs: let
    inputs =
      raw-inputs
      // {
        #: In an attempt to ensure backward compatibility with nix flakes,
        #: for some reason the `with-inputs` package does not define the
        #: `self.outPath` attribute
        self = (raw-inputs.self or {}) // {outPath = ./.;};
      };
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
in
  with-inputs outputs
