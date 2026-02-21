# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Helpers > mini.bufremove]
# Adapter for keymaps
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.nvf.enable && config.programs.nvf.settings.vim.mini.bufremove.enable;

    hapixRuntimeCfg = config.programs.nvf.settings.vim.runtimes;
  in {
    assertions = [
      {
        assertion = predicate && hapixRuntimeCfg.enable && hapixRuntimeCfg.hapix-helper.enable;
        message = "hapix.helper must be enabled to use mini.bufremove";
      }
    ];

    programs.nvf.settings.vim.keymaps = lib.mkIf predicate (
      lib.mkAfter [
        # ## Lifecycle (Delete)
        {
          key = "<leader>bd";
          mode = ["n"];
          action = ''function() MiniBufremove.delete(0, false) end'';
          desc = "Delete buffer";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bdf";
          mode = ["n"];
          action = "function() MiniBufremove.delete(0, true) end";
          desc = "Delete buffer (force)";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bdo";
          mode = ["n"];
          action = "function() HapixHelper.with_other_buffers(MiniBufremove.delete, false) end";
          desc = "Delete other buffers";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bdof";
          mode = ["n"];
          action = "function() HapixHelper.with_other_buffers(MiniBufremove.delete, true) end";
          desc = "Delete other buffers (force)";
          unique = true;
          lua = true;
        }
        # ## Lifecycle (Unload)
        {
          key = "<leader>bc";
          mode = ["n"];
          action = "function() MiniBufremove.unshow(0, false) end";
          desc = "Unload buffer";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bcf";
          mode = ["n"];
          action = "function() MiniBufremove.unshow(0, true) end";
          desc = "Unload buffer (force)";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bco";
          mode = ["n"];
          action = "function() HapixHelper.with_other_buffers(MiniBufremove.unshow, false) end";
          desc = "Unload other buffers";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bcof";
          mode = ["n"];
          action = "function() HapixHelper.with_other_buffers(MiniBufremove.unshow, true) end";
          desc = "Unload other buffers (force)";
          unique = true;
          lua = true;
        }
        # ## Lifecycle (Wipeout)
        {
          key = "<leader>bq";
          mode = ["n"];
          action = "function() MiniBufremove.wipeout(0, false) end";
          desc = "Wipeout buffer";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bqf";
          mode = ["n"];
          action = "function() MiniBufremove.wipeout(0, true) end";
          desc = "Wipeout buffer (force)";
          unique = true;
        }
        {
          key = "<leader>bqo";
          mode = ["n"];
          action = "function() HapixHelper.with_other_buffers(MiniBufremove.wipeout, false) end";
          desc = "Wipeout other buffers";
          unique = true;
          lua = true;
        }
        {
          key = "<leader>bqof";
          mode = ["n"];
          action = "function() HapixHelper.with_other_buffers(MiniBufremove.wipeout, true) end";
          desc = "Wipeout other buffers (force)";
          unique = true;
          lua = true;
        }
      ]
    );
  };
}
