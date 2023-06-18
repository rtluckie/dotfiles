{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.editors.pycharm;
in {
  options = {
    modules.applications.editors.pycharm = {
      enable =
        mkEnableOption "applications.editors.pycharm"
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
