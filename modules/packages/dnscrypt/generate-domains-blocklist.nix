# ----------------------------------------------------------------------------
# ## Packages: DNSCrypt generate-domains-blocklist
# ----------------------------------------------------------------------------
# This package is a tool to generate a DNSCrypt block lists, allow lists, etc.
{
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    name = "generate-domains-blocklist";
    version = "2.1.15";
  in {
    packages.generate-domains-blocklist = pkgs.stdenv.mkDerivation {
      pname = name;

      inherit version;

      src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-proxy/${version}/utils/${name}/${name}.py";
        hash = "sha256-7dhxPZiV1UDz0tqZ86KiKhObNBpDO+Lkh2+oe3uE8lo=";
      };

      dontUnpack = true;

      buildInputs = with pkgs; [
        python314
      ];

      installPhase = ''
        runHook preInstall

        install -Dm755 $src $out/bin/${name}

        runHook postInstall
      '';

      meta = with lib; {
        description = "Tool to generate a DNSCrypt block lists, allow lists, etc.";
        homepage = "https://github.com/DNSCrypt/dnscrypt-proxy";
        license = licenses.isc;
        mainProgram = name;
      };
    };
  };
}
