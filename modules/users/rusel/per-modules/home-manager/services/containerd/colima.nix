# =========================================================================
# == USER PROFILE: rusel (Containerization - Colima)
# This module configures Colima, a high-performance, open-source
# replacement for Docker Desktop on macOS. It manages the virtualization
# lifecycle, resource allocation, and container runtime orchestration
# within the Home Manager environment.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.colima = {
      # ### Core Activation
      # Force-enable Colima as the primary container runtime manager.
      enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Profile Configuration (default)
      # -----------------------------------------------------------------------
      profiles = {
        default = {
          isActive = true;

          # ### Service Orchestration
          # Managed as a persistent background service, ensuring the
          # container runtime is available immediately upon login.
          isService = true;

          # -----------------------------------------------------------------------
          # ## Resource & Runtime Settings
          # -----------------------------------------------------------------------
          settings = {
            # #### Hardware Allocation
            # Balanced resources for local development: 2 vCPUs and 2GB RAM.
            cpu = 2;
            memory = 2;
            disk = 50; # 50GB persistent storage for images and volumes.

            # Use the host architecture (e.g., aarch64 on Apple Silicon)
            # for native performance.
            arch = "host";

            # #### Container Engine
            # Standardize on 'docker' as the primary runtime for
            # compatibility with 'lazydocker' and existing compose files.
            runtime = "docker";

            # #### Kubernetes (Orchestration)
            # Disabled by default to minimize resource overhead; easily
            # toggleable for cloud-native development tasks.
            kubernetes = {
              enabled = false;
              version = "v1.33.3+k3s1";
              k3sArgs = ["--disable=traefik"];
            };

            # -----------------------------------------------------------------------
            # ## Networking & Integration
            # -----------------------------------------------------------------------
            autoActivate = true;

            network = {
              mode = "shared"; # Bridges the VM to the macOS network.
              interface = "en0";
              address = true;

              # ### DNS Integration
              # Bridge to local privacy stack: We point the container
              # environment to 127.0.0.1. This ensures containers
              # resolve domains through our 'dnscrypt-proxy' service.
              dns = ["127.0.0.1"];

              dnsHosts = {
                "host.docker.internal" = "host.lima.internal";
              };
            };

            # #### Virtualization Layer
            # Uses QEMU for maximum stability and compatibility.
            vmType = "qemu";
            mountType = "sshfs"; # Reliable filesystem sharing between macOS and the VM.
            cpuType = "host";
            portForwarder = "ssh";
            binfmt = true; # Support for multi-architecture builds.

            # #### Persistence
            sshConfig = true;
            rootDisk = 20;
          };
        };
      };
    };
  };
}
