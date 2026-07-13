#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> quirks -> ignore] ignore folders and files declarations
#: ----------------------------------------------------------------------------
{
  den.quirks.ignore = {
    description = "Ignoring folders and files declarations";
  };

  hapix.ignoring = {
    homeManager = {
      ignore,
      lib,
      ...
    }: let
      A = lib.mkAfter;
    in {
      programs.git.ignores = A (lib.concatMap (f: f.globs or []) ignore);
    };
  };
}
