{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.pycharm;
in {
  options = {
    modules.gui.pycharm = {
      enable =
        mkEnableOption "gui.pycharm"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [jetbrains.pycharm-professional];
    }
  ]);
}
