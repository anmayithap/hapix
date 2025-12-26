# 📂 [MODULES] / SHARED

## The Universal Library and Component Registry

This directory is the "DNA" of the entire configuration.
It contains the reusable building blocks, internal system tweaks,
and core library functions that are shared across all hosts and platforms.

The primary goal of the `shared` directory is to enforce the **DRY (Don't Repeat Yourself)** principle
by providing a centralized registry of modules that can be mixed and matched to build complete system profiles.

## CORE CONCEPTS

1. **The Registry Pattern**
   Most files in this directory do not define systems directly.
   Instead, they "inject" logic into the global flake registry using the following pattern:

   ```nix
   flake.modules.<platform>.<module-name> = { ... };
   ```

   This allows the **Configuration Factory** to resolve modules by name
   (e.g., `inputs.self.modules.darwin.networking`) without needing to know their physical file paths.

2. **Internal vs. External**

- **Internal**: Located in `internal/` subfolders,
  these modules manage low-level OS defaults (e.g., Dock, Firewall, Sleep settings).
- **Programs**: Located in `programs/` subfolders,
  these define bundles of related binaries (e.g., `editor-programs`, `network-programs`).
- **Third-Party**: Located in `third-party/`,
  these provide the bridge to external frameworks like `nix-homebrew` or `agenix`.
