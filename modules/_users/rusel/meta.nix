# ----------------------------------------------------------------------------
# ## Rusel User Module: [User Meta]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.rusel-user-meta = {
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.self.modules.generic.user-meta
    ];

    user-meta = {
      username = lib.mkForce "rusel";
      name = lib.mkForce "Ruslan";
      surname = lib.mkForce "Torbeev";
      fullname = lib.mkForce "Ruslan Torbeev";
      email = lib.mkForce "ruslan.torbeev@yandex.ru";
      homeDirectory = lib.mkForce (
        if pkgs.stdenvNoCC.isDarwin
        then "/Users/rusel"
        else "/home/rusel"
      );
    };
  };
}
