{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.alacritty = {
      enable = lib.mkDefault true;
      theme = "ayu_dark";
      settings = {
        general = {
          ipc_socket = true;
        };

        window = {
          dimensions = {
            lines = 52;
            columns = 120;
          };
          opacity = 1;
          blur = true;
          startup_mode = "Maximized";
          dynamic_title = true;
          option_as_alt = "OnlyLeft";
        };

        font = {
          normal = {
            family = "JetBrainsMono NF";
            style = "Regular";
          };
          size = 13;
        };

        selection = {
          save_to_clipboard = true;
        };
      };
    };
  };
}
