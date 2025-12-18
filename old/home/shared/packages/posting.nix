{lib, ...}: {
  custom.posting = {
    enable = lib.mkDefault true;
    config = lib.mkDefault {
      theme = "flexoki";
      watch_env_files = true;
      watch_collection_files = true;
      animation = "full";
      response = {
        prettify_json = true;
        show_size_and_time = true;
      };
      focus = {
        on_startup = "collection";
        on_response = "body";
      };
    };
  };
}
