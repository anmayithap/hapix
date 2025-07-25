{
  lib,
  profile,
  ...
}: {
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
        title = "${profile.hostname}tty";
        dynamic_title = true;
        option_as_alt = "OnlyLeft";
      };

      font = {
        normal = {
          family = "JetBrainsMono NFM";
        };
      };

      selection = {
        save_to_clipboard = true;
      };
    };
  };
}
