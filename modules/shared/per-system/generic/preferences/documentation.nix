# ----------------------------------------------------------------------------
# ## Generic Module: [Preferences > Documentation]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.documentation = {lib, ...}: {
    documentation = {
      enable = lib.mkDefault true;
      doc.enable = lib.mkDefault true;
      info.enable = lib.mkDefault true;
      man.enable = lib.mkDefault true;
    };
  };
}
