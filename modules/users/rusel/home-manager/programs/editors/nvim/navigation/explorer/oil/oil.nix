{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.utility.oil-nvim = {
      enable = lib.mkDefault true;

      setupOpts = {
        default_file_explorer = lib.mkDefault true;
        delete_to_trash = lib.mkDefault true;

        skip_confirm_for_simple_edits = lib.mkDefault true;

        view_options = {
          show_hidden = lib.mkDefault true;
          natural_order = lib.mkDefault true;

          is_always_hidden = lib.generators.mkLuaInline ''            function(name, _)
            		        	        local patterns = vim.g.ignoring_files or {}

                                        for _, pattern in ipairs(patterns) do
                                            if name:match(pattern) then
                                                return true
                                            end
                                        end

                                        return false
                        			end
          '';
        };
      };
    };
  };
}
