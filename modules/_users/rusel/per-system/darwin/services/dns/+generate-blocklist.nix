{
  flake.modules.darwin.rusel-dns = {
    lib,
    pkgs,
    config,
    ...
  }: let
    generatorConf = pkgs.writeText "domains-blocklist.conf" ''
      # OISD.nl (big) - Block ads, phishing, malware, tracking, etc.
      # Warning: This is huge list.
      https://big.oisd.nl/domainswild

      # MyBase - Block ads, malware, tracking, etc.
      https://download.dnscrypt.info/blacklists/domains/mybase.txt
    '';

    dataDirectory = config.users.users._dnscrypt-proxy.home;
    outputFile = "${dataDirectory}/domains-blocklist.txt";

    debugLogFile = "${dataDirectory}/dnscrypt-activation.log";
  in {
    system.activationScripts.extraActivation.text = lib.mkBefore ''
      mkdir -p ${dataDirectory}

      LOGFILE="${debugLogFile}"

      echo "$(date): Starting DNSCrypt blocklist generation..." > "$LOGFILE"

      echo "Running generator..." >> "$LOGFILE"

      ${pkgs.generate-domains-blocklist}/bin/generate-domains-blocklist \
        -c ${generatorConf} \
        -o ${outputFile} \
        --progress \
        --ignore-retrieval-failure \
        --timeout 5 \
        >> ${debugLogFile} 2>&1 \
        || echo "WARNING: Generator failed (see lines above)" >> "$LOGFILE"

      if [ -f "${outputFile}" ]; then
        chmod 644 "${outputFile}"
        chmod 755 "${dataDirectory}"

        echo "Permissions fixed" >> "$LOGFILE"
      else
        echo "FATAL: Output file was not created!" >> "$LOGFILE"
      fi

      echo "$(date): Finished." >> "$LOGFILE"
    '';

    services.dnscrypt-proxy.settings = {
      blocked_names = {
        blocked_names_file = lib.mkForce outputFile;

        log_file = lib.mkForce "${config.users.users._dnscrypt-proxy.home}/blocked-names.log";
      };
    };
  };
}
