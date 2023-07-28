{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.go-task;
in {
  options = {
    modules.development.tools.go-task = {
      enable =
        mkEnableOption "development.tools.go-task"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        go-task
      ];
    }
  ]);
}
