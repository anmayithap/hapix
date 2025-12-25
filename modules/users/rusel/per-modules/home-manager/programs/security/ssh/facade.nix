{
  flake.modules.homeManager.rusel = _: {
    home.file.".ssh/sockets/.keep".text = "";
  };
}
