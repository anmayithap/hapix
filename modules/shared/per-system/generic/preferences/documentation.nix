# ----------------------------------------------------------------------------
# ## Documentation Preferences Module: Configures the documentation preferences
# ----------------------------------------------------------------------------
{
  flake.modules.generic.documentation = {lib, ...}: {
    documentation = {
      enable = lib.mkDefault false;
      doc.enable = lib.mkDefault false;
      info.enable = lib.mkDefault false;
    };
  };
}
