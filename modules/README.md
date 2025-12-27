# 📂 [MODULES]

`hapix` modules and their structure. First of all, these modules
are divided into several groups:

1. [`flake` modules](./flake/README.md) - Their specificity is based on the configuration of the final outputs,
   as well as the configurations necessary for development (devshell, formatting, git hooks, etc.).
2. [`hosts` modules](./hosts/README.md) - Configure settings specific to the host machine that are not related
   to other modules.
3. [`package` modules](./packages/README.md) - These are the actual implemented package derivations.
4. [`shared` modules](./shared/README.md) - Distributed e2e configuration files for all modules.
5. [`users` modules](./users/README.md) - Here, users, user daemons, programs, and their environment
   are directly configured.
