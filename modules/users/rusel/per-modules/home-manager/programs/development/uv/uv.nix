# =========================================================================
# == USER PROFILE: rusel (Python Package Management - uv)
# This module enables 'uv', a modern and extremely fast Python package
# manager and resolver written in Rust. It serves as the primary tool
# for managing Python dependencies, virtual environments, and tool
# execution (via uvx) for the "rusel" profile.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.uv = {
      # ### Core Activation
      # Enable 'uv' globally for the user.
      # Using `lib.mkForce` ensures that this high-performance Python
      # stack is always present, providing a reliable and modern
      # alternative to pip, poetry, and virtualenv.
      enable = lib.mkForce true;

      # Note: This module works in tandem with the 'uv/+adapter.nix'
      # to provide native Zsh shell completions for the 'uvx' command.
    };
  };
}
