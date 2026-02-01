# ----------------------------------------------------------------------------
# ## Features: User Metadata Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.generic.user-meta = {lib, ...}: {
    options = {
      user-meta = {
        username = lib.mkOption {
          type = with lib.types; str;
          description = "The system username for the account";
        };
        name = lib.mkOption {
          type = lib.types.str;
          description = "First name";
        };
        surname = lib.mkOption {
          type = lib.types.str;
          description = "Last name";
        };
        fullname = lib.mkOption {
          type = lib.types.str;
          description = "The full display name of the user";
        };
        email = lib.mkOption {
          type = lib.types.str;
          description = "The user's primary email address";
        };
        homeDirectory = lib.mkOption {
          type = lib.types.str;
          description = "The absolute path to the user's home folder";
        };
      };
    };
  };
}
