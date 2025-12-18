{inputs, ...}: {
  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    rusel
    {
      networking.hostName = "maple";
      networking.localHostName = "maple";
      networking.computerName = "maple";
    }
  ];
}
