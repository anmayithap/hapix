#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> btop] A monitor of resources
#: ----------------------------------------------------------------------------
#: Source: https://github.com/aristocratos/btop
#: Documentation: https://github.com/aristocratos/btop#configurability
#: Changelog: https://github.com/aristocratos/btop/blob/main/CHANGELOG.md
{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    D = lib.mkDefault;
  in {
    packages.btop = self.wrappers.btop.wrap {
      inherit pkgs;

      btop = {
        settings = {
          color_theme = D "ayu";
          vim_keys = D true;
          update_ms = D 1000;
          proc_sorting = D "cpu direct";
          proc_reversed = D true;
          proc_tree = D true;
          proc_mem_bytes = D false;
          proc_aggregate = D true;
          cpu_graph_upper = D "total";
          cpu_graph_lower = D "iowait";
          use_fstab = D false;
          disk_free_priv = D true;
          io_mode = D true;
          io_graph_combined = D true;
          net_auto = D false;
          net_sync = D false;
        };
      };
    };
  };
}
