# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > colima]
# ----------------------------------------------------------------------------
# Source: `https://github.com/abiosoft/colima`
# Home Manager: `https://nix-community.github.io/home-manager/options.xhtml#opt-services.colima.enable`
# Derivation: `https://github.com/nix-community/home-manager/blob/master/modules/services/colima.nix`
{
  flake.modules.homeManager.colima = {
    lib,
    pkgs,
    ...
  }: let
    defaultProfile = {
      # ## Don't activate the default profile
      isActive = lib.mkDefault false;
      # ## Don't start the default profile as a service
      isService = lib.mkDefault false;

      settings = {
        # ## CPU - 4 cores
        cpu = lib.mkDefault 4;
        # ## Memory - 4 GB
        memory = lib.mkDefault 4;
        # ## Disk - 50 GB
        disk = lib.mkDefault 50;
        # ## Root Disk - 10 GB
        rootDisk = lib.mkDefault 10;
        # ## Architecture - current system host architecture (x86_64, aarch64)
        arch = lib.mkDefault "host";
        # ## VM Type - qemu by default
        vmType = lib.mkDefault "qemu";
        # ## Runtime - docker by default
        runtime = lib.mkDefault "docker";

        network = {
          # ## Host Addresses - replicate host IP addresses for port forwarding
          hostAddresses = lib.mkDefault true;
        };

        docker = {
          registry-mirrors = [
            "https://mirror.gcr.io" # Google mirror
            "https://dockerhub.timeweb.cloud" # Timeweb mirror
            "https://cr.yandex/mirror" # Yandex mirror
          ];
        };

        # ## Port Forwarder - ssh by default
        portForwarder = lib.mkDefault "ssh";
        # ## Mount Type - 9p by default
        # Better performance then sshfs
        mountType = lib.mkDefault "9p";
        # ## SSH Agent Forwarding - true by default
        forwardAgent = lib.mkDefault true;
        # ## SSH Config - false by default
        sshConfig = lib.mkDefault false;
        # ## Auto Activate - true by default
        # Automatically set as active Docker context on startup
        autoActivate = lib.mkDefault true;
      };
    };

    darwinProfile =
      lib.recursiveUpdate defaultProfile
      {
        settings = {
          # ## VM Type - vz
          # VZ Framework (macOS 13+): Apple's Virtualization Framework
          # with better performance.
          vmType = lib.mkDefault "vz";
          # ## Nested Virtualization - for M3+ Macs (Requires VZ)
          nestedVirtualization = lib.mkDefault true;

          # ## Mount Type - virtiofs by default
          # Best performance (require VZ on macOS 13+)
          mountType = lib.mkDefault "virtiofs";
        };
      };
  in {
    services.colima = {
      enable = lib.mkDefault false;
      profiles = {
        default = lib.mkDefault (
          lib.recursiveUpdate
          (
            if pkgs.stdenv.isDarwin
            then darwinProfile
            else defaultProfile
          )
          {
            isActive = lib.mkDefault true;
            setDockerHost = lib.mkDefault true;
          }
        );
        linux = defaultProfile;
        darwin = darwinProfile;
      };
    };
  };
}
