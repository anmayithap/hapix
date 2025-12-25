{
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.colima = {
      enable = lib.mkForce true;
      profiles = {
        default = {
          isActive = true;
          isService = true;

          settings = {
            cpu = 2;
            disk = 50;
            memory = 2;
            arch = "host";
            runtime = "docker";
            hostname = null;
            kubernetes = {
              enabled = false;
              version = "v1.33.3+k3s1";
              k3sArgs = ["--disable=traefik"];
              port = 0;
            };
            autoActivate = true;
            network = {
              address = true;
              mode = "shared";
              interface = "en0";
              preferredRoute = false;
              dns = [
                "127.0.0.1"
              ];
              dnsHosts = {
                "host.docker.internal" = "host.lima.internal";
              };
              hostAddresses = false;
            };
            forwardAgent = false;
            docker = {};
            vmType = "qemu";
            portForwarder = "ssh";
            rosetta = false;
            binfmt = true;
            nestedVirtualization = false;
            mountType = "sshfs";
            mountInotify = false;
            cpuType = "host";
            provision = [];
            sshConfig = true;
            sshPort = 0;
            mounts = [];
            diskImage = "";
            rootDisk = 20;
            env = {};
          };
        };
      };
    };
  };
}
