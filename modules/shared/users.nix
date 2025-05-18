{profile, ...}: {
  system.primaryUser = profile.username;

  users.users.${profile.username} = {
    name = profile.username;
    description = profile.fullname;
    home = profile.homeDirectory;
  };
}
