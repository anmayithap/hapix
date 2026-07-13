#: ----------------------------------------------------------------------------
#: ## [FEATURE -> hapix] hapix namespace declaration
#: ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    (inputs.den.namespace "hapix" true)
  ];

  hapix = {};
}
