{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.vscode;
in {
  options = {
    modules.gui.vscode = {
      enable =
        mkEnableOption "gui.vscode"
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
