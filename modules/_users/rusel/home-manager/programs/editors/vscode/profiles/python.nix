{
  flake.modules.homeManager.rusel-vscode = {config, ...}: let
    inherit (config.programs.vscode.profiles) default;
  in {
    programs.vscode.profiles.python = {
      inherit (default) extensions keybindings userSettings globalSnippets languageSnippets userMcp userTasks;
    };
  };
}
