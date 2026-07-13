# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim;
  in {
    config.wrappers.neovim = {
      settings = {
        config_directory = lib.mkDefault (
          if cfg.settings.wrapMode == "development"
          then cfg.settings.unwrapped_directory
          else cfg.settings.wrapped_directory
        );
        info_plugin_name = lib.mkDefault "${cfg.settings.name}-info";
      };

      env = {
        NVIM_APPNAME = lib.mkDefault cfg.settings.name;
      };

      info = lib.mkMerge (cfg.specCollect (acc: v: acc ++ lib.optional (v.meta or {} != {}) v.meta) []);

      prefixVar = let
        packages = cfg.specCollect (acc: v: acc ++ (v.prePkgs or [])) [];
      in
        lib.optional (packages != []) {
          name = "PREPKGS_PACKAGES";
          data = [
            "PATH"
            ":"
            "${lib.makeBinPath (lib.unique packages)}"
          ];
        };

      suffixVar = let
        packages = cfg.specCollect (acc: v: acc ++ (v.postPkgs or [])) [];
      in
        lib.optional (packages != []) {
          name = "POSTPKGS_PACKAGES";
          data = [
            "PATH"
            ":"
            "${lib.makeBinPath (lib.unique packages)}"
          ];
        };
    };
  };
}
