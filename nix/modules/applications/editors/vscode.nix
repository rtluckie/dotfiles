{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.editors.vscode;
in {
  options = {
    modules.applications.editors.vscode = {
      enable =
        mkEnableOption "applications.editors.vscode"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.vscode = {
        enable = true;
        extensions = [];
        keybindings = [];
        userSettings = {};
        userTasks = {};
      };
    }
  ]);
}
