/*
This module provides a set of validators for use with the `assert` function.

Functions:
1. validate: {pred, message} -> assertion or null
   - Takes an object with two properties:
      `pred`, which is a predicate function that returns true if the input satisfies some condition;
      and `message`, which is an optional string describing what kind of value should be passed to the predicate.
   - Returns either an assertion (if the predicate fails) or null (if it passes).
*/
{nixpkgs}: let
  inherit (nixpkgs) lib;

  defaultValidator = pred: message:
    lib.asserts.assertMsg pred message;
in {
  validate = defaultValidator;
}
